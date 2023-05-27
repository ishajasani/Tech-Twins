import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

import '../../constants.dart';

class LaboratoryContractLinking extends ChangeNotifier {
  String privateKey = "";
  final Web3Client _client = Web3Client(rpcUrl, Client());
  bool isLoading = true;

  String? abiCode;
  EthereumAddress? contractAddress;

  Credentials? credentials;
  WalletService walletServices = WalletService();

  DeployedContract? contract;
  ContractFunction? registerLaboratory;
  ContractFunction? getLaboratoryInfo;
  int chainId = 1337;

  String? deployedName;

  LaboratoryContractLinking() {
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
        await rootBundle.loadString("src/abis/LaboratoryInfo.json");
    final jsonAbi = jsonDecode(abiStringfile);
    abiCode = jsonEncode(jsonAbi['abi']);
    contractAddress =
        EthereumAddress.fromHex(jsonAbi['networks']['5557']['address']);
  }

  void getCredentials() {
    credentials = EthPrivateKey.fromHex(privateKey);
  }

  void getDeployedContract() {
    contract = DeployedContract(
        ContractAbi.fromJson(abiCode!, "LaboratoryInfo"), contractAddress!);
    registerLaboratory = contract!.function('registerLaboratory');
    getLaboratoryInfo = contract!.function('getLaboratoryInfo');
    if (kDebugMode) {
      print(contract);
    }
  }

  Future regLaboratory(String name, String recordsDelivered, String experience,
      String rating, String email, String about, String profileImageURL) async {
    isLoading = true;

    await _client.sendTransaction(
        credentials!,
        Transaction.callContract(
            contract: contract!,
            function: registerLaboratory!,
            parameters: [
              name,
              recordsDelivered,
              experience,
              rating,
              email,
              about,
              profileImageURL
            ]),
        chainId: chainId);
    if (kDebugMode) {
      print("Laboratory Registered");
    }
    notifyListeners();
  }

  Future<List> getLaboratoryData(EthereumAddress walletAdrress) async {
    List laboratories = await _client.call(
        contract: contract!,
        function: getLaboratoryInfo!,
        params: [walletAdrress]);
    if (kDebugMode) {
      print(laboratories);
    }
    notifyListeners();
    return laboratories;
  }
}
