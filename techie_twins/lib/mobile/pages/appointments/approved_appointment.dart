import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/doctor_contract_linking.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

class ApprovedAppointment extends StatefulWidget {
  final EthereumAddress doctorAddress;
  const ApprovedAppointment({super.key, required this.doctorAddress});

  @override
  State<ApprovedAppointment> createState() => _ApprovedAppointmentState();
}

class _ApprovedAppointmentState extends State<ApprovedAppointment> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  DoctorContractLinking doctorContractLinking = DoctorContractLinking();
  void getData() {
    WalletService().getPrivateKey().then((value) {
      doctorContractLinking
          .getAppointment(widget.doctorAddress)
          .then((value) => print(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Placeholder(),
      ),
    );
  }
}
