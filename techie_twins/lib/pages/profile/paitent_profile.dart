import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techie_twins/config/contract_linking.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/pages/profile/edit_details.dart';
import 'package:techie_twins/pages/profile/wallet_profile.dart';
import 'package:web3dart/web3dart.dart';

class PaitentProfile extends StatefulWidget {
  const PaitentProfile({super.key});

  @override
  State<PaitentProfile> createState() => _PaitentProfileState();
}

class _PaitentProfileState extends State<PaitentProfile> {
  ContractLinking contractLinking = ContractLinking();
  WalletService walletService = WalletService();
  Credentials? credentials;
  Future<List>? patientModel_;
  String name = "";
  String age = "";
  String gender = "";
  String email = "";
  String phone = "";
  String height = "";
  String weight = "";
  String profileUrl = "";

  getData() async {
    String privKey = await walletService.getPrivateKey();
    credentials = EthPrivateKey.fromHex(privKey);
    setState(() {});
  }

  getPatientData() async {
    await getData();

    Future.delayed(const Duration(milliseconds: 1000), () {
      patientModel_ = contractLinking.getUserData(credentials!.address);
    });
    populateData();

    setState(() {});
  }

  populateData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      patientModel_!.then((value) {
        name = value[0];
        age = value[1];
        gender = value[2];
        email = value[3];
        phone = value[4];
        height = value[5];
        weight = value[6];
        profileUrl = value[7];
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPatientData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "create or edit your profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 10),
                  )),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 120),
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WalletProfile())),
                        child: BlurryContainer(
                          borderRadius: BorderRadius.circular(25),
                          width: MediaQuery.of(context).size.width / 3.6,
                          blur: 5,
                          color: Colors.black.withOpacity(.2),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.wallet_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Wallet",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 3.7,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$gender: $age",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 20),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          HeightTile(
                            height: height,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          WeightTile(
                            weight: weight,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const BloodTile(
                            blood: "b",
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.7,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.blueAccent),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Your health records",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.blueAccent),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10),
                        child: Text(
                          "Your appointments",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
                heroTag: "2",
                backgroundColor: Colors.blueGrey[300]!.withOpacity(.5),
                elevation: 0,
                icon: const Icon(
                  Icons.edit_note,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditDetails())),
                label: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton.extended(
                heroTag: "1",
                backgroundColor: Colors.blueGrey[300]!.withOpacity(.5),
                elevation: 0,
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
                label: const Text(
                  "Home",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
          ],
        ));
  }
}

class HeightTile extends StatelessWidget {
  final String height;
  const HeightTile({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        // elevation: 1,
        width: 110,
        height: 120,
        color: Colors.black.withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Height",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Text(
                height,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "CM",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}

class WeightTile extends StatelessWidget {
  final String weight;
  const WeightTile({
    super.key,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        // elevation: 1,
        width: 110,
        height: 120,
        color: Colors.black.withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Weight",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Text(
                weight,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "KG",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}

class BloodTile extends StatelessWidget {
  final String blood;
  const BloodTile({
    super.key,
    required this.blood,
  });

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        // elevation: 1,
        width: 110,
        height: 120,
        color: Colors.black.withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Blood",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Text(
                blood,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "+VE",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}
