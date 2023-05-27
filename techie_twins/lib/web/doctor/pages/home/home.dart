import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/doctor_contract_linking.dart';
import 'package:techie_twins/web/doctor/pages/profile/doctor_profile.dart';

import 'package:techie_twins/widgets/custom_tiles.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../config/contract_linking/patient_contract_linking.dart';

class Home extends StatefulWidget {
  final EthereumAddress docAddress;
  const Home({super.key, required this.docAddress});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DoctorContractLinking doctorContractLinking = DoctorContractLinking();
  List appointmentData = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    getDocData();
  }

  bool isLoading = false;

  List patientData = List.empty(growable: true);
  PatientContractLinking contractLinking = PatientContractLinking();
  void getDocData() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      doctorContractLinking.getAppointment(widget.docAddress).then((value) {
        if (kDebugMode) {
          print(value);
        }
        value.forEach((val) {
          val.forEach((val1) {
            setState(() {
              appointmentData.add(val1);
            });
            contractLinking.getUserData(val1[0]).then((value) {
              setState(() {
                patientData.add(value);
              });
              Future.delayed(const Duration(milliseconds: 1000), () {
                setState(() {
                  isLoading = false;
                });
              });
            });
          });
        });
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  void confirmAppointment(int index) async {
    await doctorContractLinking.confirmAppointmentFunction(BigInt.from(index));
  }

  String ipfsImgeUrl = 'https://ipfs.io/ipfs/';
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Length of patient data: ${patientData.length}");
      print("Length of appointment data: ${appointmentData.length}");
    }
    return Scaffold(
        extendBody: true,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your',
                              style: TextStyle(
                                  height: 1,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'patients',
                              style: TextStyle(
                                  height: 1,
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const DoctorProfile())),
                            child: Text(
                              "your profile",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 50),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.41,
                          width: MediaQuery.of(context).size.width / 3,
                          child: GridView.builder(
                            itemCount: 10,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 400,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: ((context, index) {
                              return PatientTile(
                                age: '21',
                                consultTap: () {},
                                gender: 'Male',
                                imageURL:
                                    'https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80',
                                intoTap: () {},
                                name: 'David Smith',
                              );
                            }),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.41,
                          width: MediaQuery.of(context).size.width / 3,
                          child: GridView.builder(
                            itemCount: appointmentData.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 400,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: ((context, index) {
                              // ignore: unnecessary_null_comparison
                              return index != null
                                  ? PatientConfirmationTile(
                                      age: patientData[index][2],
                                      cancelTap: () {},
                                      gender: patientData[index][5],
                                      imageURL:
                                          ipfsImgeUrl + patientData[index][8],
                                      confirmTap: () {
                                        confirmAppointment(index);
                                      },
                                      name: patientData[index][0],
                                    )
                                  : const Center(child: Text("Is loading.."));
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }
}
