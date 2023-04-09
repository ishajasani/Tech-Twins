import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

import '../../constants.dart';

class DoctorContractLinking extends ChangeNotifier {
  String privateKey = "";
  final Web3Client _client = Web3Client(rpcUrl, Client());
  bool isLoading = true;

  String? abiCode;
  EthereumAddress? contractAddress;

  Credentials? credentials;
  WalletService walletServices = WalletService();

  DeployedContract? contract;
  ContractFunction? registerDoctor;
  ContractFunction? getDoctorInfo;
  int chainId = 1337;

  String? deployedName;

  DoctorContractLinking() {
    setup();
  }

  setup() async {
    await getData();
    await getAbi();
    getCredentials();
    getDeployedContract();
  }

  getData() async {
    privateKey = await walletServices.getPrivateKey();
  }

  Future<void> getAbi() async {
    String abiStringfile =
        await rootBundle.loadString("src/abis/DoctorInfo.json");
    final jsonAbi = jsonDecode(abiStringfile);
    abiCode = jsonEncode(jsonAbi['abi']);
    contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  void getCredentials() {
    credentials = EthPrivateKey.fromHex(privateKey);
  }

  void getDeployedContract() {
    contract = DeployedContract(
        ContractAbi.fromJson(abiCode!, "DoctorInfo"),
        contractAddress!);
    registerDoctor = contract!.function('registerDoctor');
    getDoctorInfo = contract!.function('getDoctorInfo');
    print(contract);
  }

  regDoctor(
      String name,
      String patientCount,
      String experience,
      String gender,
      String rating,
      String email,
      String about,
      String profileImageURL) async {
    isLoading = true;

    await _client.sendTransaction(
        credentials!,
        Transaction.callContract(
            contract: contract!,
            function: registerDoctor!,
            parameters: [
              name,
              patientCount,
              experience,
              gender,
              rating,
              email,
              about,
              profileImageURL
            ]),
        chainId: chainId);
    if (kDebugMode) {
      print("Doctor Registered");
    }
    notifyListeners();
  }

  Future<List> getDoctorData(EthereumAddress walletAdrress) async {
    List doctors = await _client.call(
        contract: contract!,
        function: getDoctorInfo!,
        params: [walletAdrress]);
    if (kDebugMode) {
      print(doctors);
    }
    notifyListeners();
    return doctors;
  }
}
