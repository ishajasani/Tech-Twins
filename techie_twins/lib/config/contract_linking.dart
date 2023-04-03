import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/models/patient_model.dart';
import 'package:web3dart/web3dart.dart';

import '../constants.dart';

class ContractLinking {
  String privateKey = "";
  final Web3Client _client = Web3Client(rpcUrl, Client());
  bool isLoading = true;

  String? abiCode;
  EthereumAddress? contractAddress;

  Credentials? credentials;
  WalletService walletServices = WalletService();

  DeployedContract? contract;
  ContractFunction? registerPatient;
  ContractFunction? getPatientData;
  ContractFunction? setPatientRecordCids;
  ContractFunction? getPatientRecordCids;
  int chainId = 1337;

  String? deployedName;

  ContractLinking() {
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
        await rootBundle.loadString("src/abis/PatientRegistration.json");
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
        ContractAbi.fromJson(abiCode!, "PatientRegistration"),
        contractAddress!);
    registerPatient = contract!.function('registerPatient');
    getPatientData = contract!.function('getPatient');
    setPatientRecordCids = contract!.function('setPatientRecordCids');
    getPatientRecordCids = contract!.function('getPatientRecordCids');
    // print(contract);
  }

  regUser(String username, String age, String height, String weight,
      String gender, String email, String phone, String profileUrl) async {
    isLoading = true;
    // notifyListeners();

    await _client.sendTransaction(
        credentials!,
        Transaction.callContract(
            contract: contract!,
            function: registerPatient!,
            parameters: [
              username,
              age,
              height,
              weight,
              gender,
              email,
              phone,
              profileUrl
            ]),
        chainId: chainId);
    print("User Registered");
  }

  sendUserCid(String cid) async {
    isLoading = true;
    // notifyListeners();

    await _client.sendTransaction(
        credentials!,
        Transaction.callContract(
            contract: contract!,
            function: setPatientRecordCids!,
            parameters: [cid]),
        chainId: chainId);
    print("User Registered");
  }

  Future<List> getUserData(EthereumAddress walletAdrress) async {
    List patients = await _client.call(
        contract: contract!,
        function: getPatientData!,
        params: [walletAdrress]);
    print(patients);
    return patients;
    // notifyListeners();
  }

  getUserCid() async {
    List patients = await _client
        .call(contract: contract!, function: getPatientRecordCids!, params: []);
    print('---------------------------');
    print(patients);
    isLoading = false;
    return patients;
    // notifyListeners();
  }
}
