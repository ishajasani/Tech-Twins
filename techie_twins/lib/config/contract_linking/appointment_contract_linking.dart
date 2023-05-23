import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

import '../../constants.dart';

class AppointmentContractLinking extends ChangeNotifier {
  String privateKey = "";
  final Web3Client _client = Web3Client(rpcUrl, Client());
  bool isLoading = true;

  String? abiCode;
  EthereumAddress? contractAddress;

  Credentials? credentials;
  WalletService walletServices = WalletService();

  DeployedContract? contract;
  ContractFunction? bookAppointment;
  ContractFunction? confirmAppointment;
  ContractFunction? getAppointment;
  int chainId = 1337;

  String? deployedName;

  AppointmentContractLinking() {
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
        await rootBundle.loadString("src/abis/DoctorAppointment.json");
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
        ContractAbi.fromJson(abiCode!, "DoctorAppointment"), contractAddress!);
    bookAppointment = contract!.function('bookAppointment');
    confirmAppointment = contract!.function('confirmAppointment');
    getAppointment = contract!.function("getAppointment");
    if (kDebugMode) {
      print(contract);
    }
  }

  bookAppointmentFunction(BigInt appointmentTimestamp) async {
    isLoading = true;

    await _client.sendTransaction(
        credentials!,
        Transaction.callContract(
            contract: contract!,
            function: bookAppointment!,
            parameters: [appointmentTimestamp]),
        chainId: chainId);
    if (kDebugMode) {
      print("appointment booked");
    }
    getAppointments(BigInt.from(1));
    notifyListeners();
  }

  Future<void> confirmAppointmentFunction(UintType appointmentId) async {
    await _client.call(
        contract: contract!,
        function: confirmAppointment!,
        params: [appointmentId]);
    if (kDebugMode) {
      print("Appointment Confirmed");
    }
    notifyListeners();
  }

  Future<List> getAppointments(BigInt appointmentid) async {
    List appointments = await _client.call(
        contract: contract!,
        function: getAppointment!,
        params: [appointmentid]);
    if (kDebugMode) {
      print(appointments);
    }
    return appointments;
  }
}
