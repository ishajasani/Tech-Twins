import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class ApprovedAppointment extends StatefulWidget {
  final EthereumAddress doctorAddress;
  const ApprovedAppointment({super.key, required this.doctorAddress});

  @override
  State<ApprovedAppointment> createState() => _ApprovedAppointmentState();
}

class _ApprovedAppointmentState extends State<ApprovedAppointment> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Placeholder(),
      ),
    );
  }
}