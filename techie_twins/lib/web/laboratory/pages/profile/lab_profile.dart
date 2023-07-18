import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/contract_linking/laboratory_contract_linking.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/main.dart';
import 'package:techie_twins/web/laboratory/pages/profile/edit_details.dart';
import 'package:techie_twins/widgets/custom_tiles.dart';
import 'package:web3dart/web3dart.dart';

class LabProfile extends StatefulWidget {
  const LabProfile({super.key});

  @override
  State<LabProfile> createState() => _LabProfileState();
}

class _LabProfileState extends State<LabProfile> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  double accountBalance = 0;
  WalletProvider walletProvider = WalletProvider();
  bool isLoading = false;
  getUserData() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      walletProvider.initializeWalletLab().then((value) {
        Web3Client(rpcUrl, Client())
            .getBalance(
                EthereumAddress.fromHex(walletProvider.ethereumAddress!.hex))
            .then((value) {
          setState(() {
            accountBalance = value.getInEther.toDouble();
            isLoading = false;
          });
        });
      });
    });

    if (kDebugMode) {
      print("Balance: $accountBalance");
      print(walletProvider.ethereumAddress);
    }
    getDetails();
    setState(() {});
  }

  LaboratoryContractLinking contractLinking = LaboratoryContractLinking();
  Credentials? credentials;
  Future<List>? patientModel_;
  String name = "Mohit";
  String exp = "21";
  String rating = "male";
  String email = "";
  String about = "";
  String profileUrl = "";
  String recordsGenerated = "";
  getDetails() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      patientModel_ =
          contractLinking.getLaboratoryData(walletProvider.ethereumAddress!);
      populateData();
    });
    setState(() {
      // isFetching = false;
    });
  }

  populateData() async {
    await patientModel_!.then((value) {
      name = value[0];
      recordsGenerated = value[1];
      exp = value[2];
      rating = value[3];
      email = value[4];
      about = value[5];
      profileUrl = value[6];
    });
    buildUrl = ipfsURL + profileUrl;
    if (kDebugMode) {
      print('------------------');
    }
    if (kDebugMode) {
      print(buildUrl);
    }
    setState(() {});
  }

  String buildUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
              onPressed: () {
                WalletService().removePrivateKey().then((value) {
                  Fluttertoast.showToast(msg: "Logged out successfully");
                  return Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const WebLab()));
                });
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              )),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Text(
                          "lab profile",
                          style: TextStyle(
                              height: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 20),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4.5,
                            height: MediaQuery.of(context).size.height / 2.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(buildUrl))),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.5,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      LabReportGeneratedInfoTile(
                                        reports: recordsGenerated,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ExpInfoTile(years: exp),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      RatingInfoTile(stars: rating)
                                    ],
                                  ),
                                  const Text(
                                    "About",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      width: 400,
                                      child: Text(
                                        about,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Your balance",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "$accountBalance ETH",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1,
                            fontSize: MediaQuery.of(context).size.width / 20),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70, right: 70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "tech by",
                              style: TextStyle(
                                  height: 1,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 50,
                                  color: Colors.black54),
                            ),
                            Text(
                              "Techie",
                              style: TextStyle(
                                  height: 1,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              "Twins",
                              style: TextStyle(
                                  height: 1,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            const Image(
                              image: AssetImage('assets/doctors1.png'),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditDetailsLaboratory())),
                        child: Text(
                          "edit profile",
                          style: TextStyle(
                              height: 1,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width / 20),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
