import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/contract_linking/laboratory_contract_linking.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/widgets/custom_tiles.dart';
import 'package:web3dart/web3dart.dart';

class HomeLaboratory extends StatefulWidget {
  const HomeLaboratory({super.key});

  @override
  State<HomeLaboratory> createState() => _HomeLaboratoryState();
}

class _HomeLaboratoryState extends State<HomeLaboratory> {
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  double accountBalance = 0;
  WalletProvider walletProvider = WalletProvider();

  getUserData() async {
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
      body: Container(
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
                                  fontSize: 40, fontWeight: FontWeight.bold),
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
                            fontSize: MediaQuery.of(context).size.width / 50,
                            color: Colors.black54),
                      ),
                      Text(
                        "Techie",
                        style: TextStyle(
                            height: 1,
                            fontSize: MediaQuery.of(context).size.width / 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "Twins",
                        style: TextStyle(
                            height: 1,
                            fontSize: MediaQuery.of(context).size.width / 40,
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
                  onPressed: () {},
                  child: Text(
                    "proceed",
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
