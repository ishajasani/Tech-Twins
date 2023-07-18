import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/laboratory_contract_linking.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/mobile/pages/laboratories/lab_profile.dart';
import 'package:techie_twins/widgets/custom_tiles.dart';
import 'package:web3dart/web3dart.dart';

class PickALab extends StatefulWidget {
  const PickALab({super.key});

  @override
  State<PickALab> createState() => _PickALabState();
}

class _PickALabState extends State<PickALab> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoading = false;

  LaboratoryContractLinking laboratoryContractLinking =
      LaboratoryContractLinking();
  List labs = List.empty(growable: true);
  List labProfile = List.empty(growable: true);
  EthereumAddress? ethereumAddress;
  void getData() {
    WalletService().getPrivateKey().then((val) {
      setState(() {
        isLoading = true;
        ethereumAddress = EthPrivateKey.fromHex(val).address;
      });
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      laboratoryContractLinking.getLaboratoryAdd().then((value) {
        for (var element in value) {
          element.forEach((val) {
            labs.add(val);
            laboratoryContractLinking.getLaboratoryData(val).then((value) {
              setState(() {
                labProfile.add(value);
                isLoading = false;
              });
            });
          });
        }
      });
    });
    setState(() {
      isLoading = false;
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
                      height: 40,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(
                          "pick a laboratory",
                          style: TextStyle(
                              height: 1,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 10),
                        )),
                    ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: labs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (labs.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return LabTile(
                                designation: labProfile[index][4],
                                exp: labProfile[index][2],
                                name: labProfile[index][0],
                                stars: labProfile[index][3],
                                imageUrl: ipfsURL + labProfile[index][6],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LabProfile(
                                                labAddress: labs[index],
                                              )));
                                });
                          }
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
