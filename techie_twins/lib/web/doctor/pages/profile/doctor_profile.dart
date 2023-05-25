import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/contract_linking/doctor_contract_linking.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/main.dart';
import 'package:techie_twins/web/doctor/pages/profile/edit_details.dart';
import 'package:techie_twins/widgets/custom_tiles.dart';
import 'package:web3dart/web3dart.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  double accountBalance = 0;
  WalletProvider walletProvider = WalletProvider();

  getUserData() async {
    setState(() {
      isFetching = true;
    });
    await walletProvider.initializeWallet();
    EtherAmount etherAmount = await Web3Client(rpcUrl, Client()).getBalance(
        EthereumAddress.fromHex(walletProvider.ethereumAddress!.hex));
    accountBalance = etherAmount.getInEther.toDouble();

    if (kDebugMode) {
      print("Balance: $accountBalance");
      print(walletProvider.ethereumAddress);
    }
    getDetails();
    setState(() {});
  }

  DoctorContractLinking contractLinking = DoctorContractLinking();
  Credentials? credentials;
  Future<List>? patientModel_;
  String name = "Mohit";
  String exp = "21";
  String gender = "male";
  String email = "";
  String about = "";
  String rating = "";
  String profileUrl = "";
  String patientCount = "";
  bool isFetching = true;
  getDetails() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      patientModel_ =
          contractLinking.getDoctorData(walletProvider.ethereumAddress!);
      populateData();
    });
    setState(() {
      // isFetching = false;
    });
  }

  populateData() async {
    await patientModel_!.then((value) {
      name = value[0];
      patientCount = value[2];
      exp = value[3];
      gender = value[4];
      rating = value[5];
      email = value[6];
      about = value[7];
      profileUrl = value[8];
    });
    buildUrl = ipfsURL + profileUrl;
    if (kDebugMode) {
      print(buildUrl);
    }
    setState(() {
      isFetching = false;
    });
  }

  WalletService walletService = WalletService();
  String buildUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              walletService.removePrivateKey().then((value) {
                Fluttertoast.showToast(msg: "Logged out successfully");
                return Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Web()));
              });
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: isFetching
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
                          "doctor profile",
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
                                    image: profileUrl == ""
                                        ? const NetworkImage(
                                            "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80")
                                        : NetworkImage(buildUrl))),
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
                                      PatientTreatedInfoTile(
                                        patients: patientCount,
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
                            builder: (context) => const EditDetailsDoctor(),
                          ),
                        ),
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
