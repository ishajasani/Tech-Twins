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
  ContractFunction? doctorAddresses;
  ContractFunction? bookAppointment;
  ContractFunction? confirmAppointments;
  ContractFunction? getAppointments;
  ContractFunction? declineAppointment;
  ContractFunction? getMeetingLink;
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
        EthereumAddress.fromHex(jsonAbi['networks']['5557']['address']);
  }

  void getCredentials() {
    credentials = EthPrivateKey.fromHex(privateKey);
  }

  void getDeployedContract() {
    contract = DeployedContract(
        ContractAbi.fromJson(abiCode!, "DoctorInfo"), contractAddress!);
    registerDoctor = contract!.function('registerDoctor');
    getDoctorInfo = contract!.function('getDoctorInfo');
    doctorAddresses = contract!.function("getDoctorAdd");
    bookAppointment = contract!.function("bookAppointment");
    getAppointments = contract!.function("getAppointments");
    confirmAppointments = contract!.function("appointmentConfirmed");
    declineAppointment = contract!.function("declineAppointment");
    getMeetingLink = contract!.function("getMeetingLink");
  }

  Future regDoctor(
      String name,
      String desig,
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
              desig,
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
        contract: contract!, function: getDoctorInfo!, params: [walletAdrress]);
    // if (kDebugMode) {
    //   print(doctors);
    // }
    notifyListeners();
    return doctors;
  }

  Future<List> getDoctorAdd() async {
    List doctors = await _client
        .call(contract: contract!, function: doctorAddresses!, params: []);
    if (kDebugMode) {
      print(doctors);
    }
    return doctors;
  }

  Future bookAppointmentFunction(
      BigInt appointmentTimestamp,
      EthereumAddress docAddress,
      EthereumAddress patientAddress,
      String meetingLink) async {
    isLoading = true;

    await _client.sendTransaction(
        credentials!,
        Transaction.callContract(
            contract: contract!,
            function: bookAppointment!,
            parameters: [
              appointmentTimestamp,
              docAddress,
              patientAddress,
              meetingLink
            ]),
        chainId: chainId);
    if (kDebugMode) {
      print("appointment booked");
    }
    // getAppointments(BigInt.from(1));
  }

  Future confirmAppointmentFunction(
      BigInt appointmentId, EthereumAddress docAddress) async {
    await _client.sendTransaction(
        credentials!,
        Transaction.callContract(
            contract: contract!,
            function: confirmAppointments!,
            parameters: [appointmentId, docAddress]),
        
        chainId: chainId);

    if (kDebugMode) {
      print("Appointment Confirmed");
    }
    notifyListeners();
  }

  Future getAppointment(EthereumAddress docAddress) async {
    var appointments = await _client.call(
        contract: contract!, function: getAppointments!, params: [docAddress]);
    if (kDebugMode) {
      print("appointments");
    }
    return appointments;
  }

  declinePatientAppointment(BigInt index, EthereumAddress docAddress) async {
    await _client.call(
        contract: contract!,
        function: declineAppointment!,
        params: [index, docAddress]);
  }

  Future getAppointmentLink(BigInt index, EthereumAddress docAddress) async {
    var meetingLink = await _client.call(
        contract: contract!,
        function: getMeetingLink!,
        params: [index, docAddress]);

    if (kDebugMode) {
      print(meetingLink);
    }
  }
}
