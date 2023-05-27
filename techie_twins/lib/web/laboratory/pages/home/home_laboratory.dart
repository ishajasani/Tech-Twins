import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/laboratory_contract_linking.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/web/doctor/pages/profile/doctor_profile.dart';
import 'package:techie_twins/web/laboratory/pages/profile/lab_profile.dart';

import 'package:techie_twins/widgets/custom_tiles.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../config/contract_linking/patient_contract_linking.dart';

class HomeLaboratory extends StatefulWidget {
  final EthereumAddress docAddress;
  const HomeLaboratory({super.key, required this.docAddress});

  @override
  State<HomeLaboratory> createState() => _HomeLaboratoryState();
}

class _HomeLaboratoryState extends State<HomeLaboratory> {
  LaboratoryContractLinking labContractLinking = LaboratoryContractLinking();
  List appointmentData = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isLoading = false;

  List patientData = List.empty(growable: true);
  PatientContractLinking contractLinking = PatientContractLinking();
  void getData() {
    setState(() {
      isLoading = true;
    });
    WalletProvider().initializeWalletLab().then((value) {
      print(value);
    });
    // Future.delayed(const Duration(milliseconds: 1000), () {
    //   labContractLinking.getLaboratoryData(widget.docAddress).then((value) {
    //     if (kDebugMode) {
    //       print(value);
    //     }
    //     value.forEach((val) {
    //       val.forEach((val1) {
    //         setState(() {
    //           appointmentData.add(val1);
    //         });
    //         contractLinking.getUserData(val1[0]).then((value) {
    //           setState(() {
    //             patientData.add(value);
    //           });
    //           Future.delayed(const Duration(milliseconds: 1000), () {
    //             setState(() {
    //               isLoading = false;
    //             });
    //           });
    //         });
    //       });
    //     });
    //   });
    // });
    setState(() {
      isLoading = false;
    });
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
                                    builder: (_) => const LabProfile())),
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
                            itemCount: 10,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 400,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: ((context, index) {
                              // ignore: unnecessary_null_comparison
                              return index != null
                                  ? PatientTile(
                                      age: '21',
                                      consultTap: () {},
                                      gender: 'Male',
                                      imageURL:
                                          'https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80',
                                      intoTap: () {},
                                      name: 'David Smith',
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
