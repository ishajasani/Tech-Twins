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
  ContractFunction? getAllLaboratory;
  ContractFunction? requestReport;
  ContractFunction? generateReport;
  ContractFunction? getReport;
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
    privateKey = await walletServices.getPrivateKeyLab();
  }

  Future<void> getAbi() async {
    String abiStringfile =
        await rootBundle.loadString("src/abis/LaboratoryInfo.json");
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
        ContractAbi.fromJson(abiCode!, "LaboratoryInfo"), contractAddress!);
    registerLaboratory = contract!.function('registerLaboratory');
    getLaboratoryInfo = contract!.function('getLaboratoryInfo');
    getAllLaboratory = contract!.function('getAllLaboratory');
    requestReport = contract!.function('requestReport');
    generateReport = contract!.function('generateReport');
    getReport = contract!.function('getReport');
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
      print("laboratories");
    }
    notifyListeners();
    return laboratories;
  }

  Future<List> getLaboratoryAdd() async {
    List laboratories = await _client
        .call(contract: contract!, function: getAllLaboratory!, params: []);
    if (kDebugMode) {
      print("laboratories");
    }
    return laboratories;
  }

  requestLaboratoryReport(EthereumAddress docAddress, String reportType,
      EthereumAddress labAddress, EthereumAddress patientAddress) async {
    await _client.call(
        contract: contract!,
        function: requestReport!,
        params: [docAddress, reportType, labAddress, patientAddress]);
  }

  generatePatientReport(EthereumAddress patientAddress,
      EthereumAddress labAddress, List reportCids) async {
    await _client.call(
        contract: contract!,
        function: generateReport!,
        params: [patientAddress, labAddress, reportCids]);
  }

  Future getPatientReport(
      EthereumAddress patientAddress, EthereumAddress labAddress) async {
    var report = await _client.call(
        contract: contract!,
        function: getReport!,
        params: [patientAddress, labAddress]);
    if (kDebugMode) {
      print(report);
    }
  }
}
