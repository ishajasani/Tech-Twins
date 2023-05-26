import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techie_twins/config/contract_linking/patient_contract_linking.dart';
import 'package:web3dart/web3dart.dart';

import '../../../config/contract_linking/doctor_contract_linking.dart';

class PatientAppointments extends StatefulWidget {
  final EthereumAddress patientAddress;

  const PatientAppointments({super.key, required this.patientAddress});

  @override
  State<PatientAppointments> createState() => _PatientAppointmentsState();
}

class _PatientAppointmentsState extends State<PatientAppointments> {
  @override
  void initState() {
    getAppointment();
    super.initState();
  }

  bool isLoading = false;

  PatientContractLinking patientContractLinking = PatientContractLinking();
  List appointments = List.empty(growable: true);
  List doctors = List.empty(growable: true);

  String buildTimeAndDate(BigInt timestamp) {
    int convert = int.parse(timestamp.toString());
    final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(convert);
    return date1.toString().split(' ')[0];
  }

  getAppointment() {
    setState(() {
      isLoading = true;
    });
    DoctorContractLinking doctorContractLinking = DoctorContractLinking();
    Future.delayed(const Duration(milliseconds: 1000), () {
      patientContractLinking
          .getPatientAppointments(widget.patientAddress)
          .then((value) {
        value.forEach((element) {
          element.forEach((val) {
            setState(() {
              appointments.add(val);
              print(val);
              doctorContractLinking.getDoctorData(val[0]).then((value) {
                setState(() {
                  print(value);
                  doctors.add(value);
                  setState(() {
                    isLoading = false;
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Text(
                            "Your appointments",
                            style: TextStyle(
                                height: 1,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 10),
                          )),
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(doctors[index][0],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(doctors[index][1]),
                              trailing: Text(
                                  buildTimeAndDate(appointments[index][1])),
                            );
                          })
                    ],
                  ),
                ),
              ));
  }
}
