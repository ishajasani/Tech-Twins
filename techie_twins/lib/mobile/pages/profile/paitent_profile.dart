import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techie_twins/config/contract_linking/patient_contract_linking.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/main.dart';
import 'package:techie_twins/mobile/pages/appointments/patient_appointments.dart';
import 'package:techie_twins/mobile/pages/profile/edit_details.dart';
import 'package:techie_twins/mobile/pages/profile/wallet_profile.dart';
import 'package:web3dart/web3dart.dart';

class PaitentProfile extends StatefulWidget {
  const PaitentProfile({super.key});

  @override
  State<PaitentProfile> createState() => _PaitentProfileState();
}

class _PaitentProfileState extends State<PaitentProfile> {
  PatientContractLinking contractLinking = PatientContractLinking();
  WalletService walletService = WalletService();
  Credentials? credentials;
  Future<List>? patientModel_;
  String name = "Mohit";
  String age = "21";
  String gender = "male";
  String email = "";
  String phone = "";
  String height = "";
  String weight = "";
  String profileUrl = "";
  String blood = "";
  bool isSelected = false;
  String path = "";

  getData() async {
    String privKey = await walletService.getPrivateKey();
    credentials = EthPrivateKey.fromHex(privKey);
    setState(() {});
  }

  bool isFetching = false;

  getPatientData() async {
    setState(() {
      isFetching = true;
    });
    await getData();

    Future.delayed(const Duration(milliseconds: 1000), () {
      patientModel_ = contractLinking.getUserData(credentials!.address);
      populateData();
    });
  }

  populateData() async {
    await patientModel_!.then((value) {
      name = value[0];
      blood = value[1];
      age = value[2];
      gender = value[5];
      email = value[6];
      phone = value[7];
      height = value[3];
      weight = value[4];
      profileUrl = value[8];
    });

    setState(() {
      isFetching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPatientData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                walletService.removePrivateKey().then((value) {
                  Fluttertoast.showToast(msg: "Logged out successfully");
                  return Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Mobile()));
                });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EditDetails())),
        icon: const Icon(Icons.edit),
        label: const Text("Edit"),
      ),
      body: isFetching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        "Your profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 10),
                      )),
                  isFetching
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Stack(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 120),
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(ipfsURL + profileUrl),
                                  ),
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
                                          builder: (context) => WalletProfile(
                                                imageUrl: ipfsURL + profileUrl,
                                                name: name,
                                              ))),
                                  child: BlurryContainer(
                                    borderRadius: BorderRadius.circular(25),
                                    width:
                                        MediaQuery.of(context).size.width / 3.6,
                                    blur: 5,
                                    color: Colors.black.withOpacity(.2),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
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
                              top: MediaQuery.of(context).size.height / 3.9,
                              left: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$gender: $age",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15),
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
                                    BloodTile(
                                      blood: blood,
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
                                  height: 1,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientAppointments(
                                      patientAddress: credentials!.address,
                                    ))),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.blueAccent),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 10),
                              child: Text(
                                "Your appointments",
                                style: TextStyle(
                                    height: 1,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
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

class PatientsTreatedTile extends StatelessWidget {
  final String patientTreated;
  const PatientsTreatedTile({
    super.key,
    required this.patientTreated,
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
                "Patients",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Text(
                patientTreated,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "treated",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}

class ReportsTile extends StatelessWidget {
  final String reports;
  const ReportsTile({
    super.key,
    required this.reports,
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
                "Reports",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Text(
                reports,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "genetated",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}

class ExpTile extends StatelessWidget {
  final String years;
  const ExpTile({
    super.key,
    required this.years,
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
                "Exp",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Text(
                "$years+",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "years",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}

class RatingTile extends StatelessWidget {
  final String stars;
  const RatingTile({
    super.key,
    required this.stars,
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
                "Exp",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              const Spacer(),
              Text(
                stars,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "stars",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}
