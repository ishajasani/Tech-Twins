import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/laboratory_contract_linking.dart';
import 'package:techie_twins/constants.dart';
import 'package:web3dart/web3dart.dart';

import '../profile/paitent_profile.dart';

class LabProfile extends StatefulWidget {
  final EthereumAddress labAddress;
  const LabProfile({super.key, required this.labAddress});

  @override
  State<LabProfile> createState() => _LabProfileState();
}

class _LabProfileState extends State<LabProfile> {
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  bool isLoading = false;

  String name = "";
  String records = "";
  String exp = "";
  String rating = "";
  String email = "";
  String about = "";
  String imageUrl = "";
  LaboratoryContractLinking laboratoryContractLinking =
      LaboratoryContractLinking();
  void getInfo() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      laboratoryContractLinking
          .getLaboratoryData(widget.labAddress)
          .then((value) {
        setState(() {
          name = value[0];
          records = value[1];
          exp = value[2];
          rating = value[3];
          email = value[4];
          about = value[5];
          imageUrl = value[6];
          isLoading = false;
        });
      });
    });
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body:isLoading ? const Center(child: CircularProgressIndicator(),): Container(
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "lab's\nprofile",
                    style: TextStyle(
                        height: 1,
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
                        image: DecorationImage(
                          opacity: .8,
                          fit: BoxFit.cover,
                          image: NetworkImage(ipfsURL + imageUrl),
                        ),
                        backgroundBlendMode: BlendMode.darken,
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 3.9,
                    left: 30,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 15),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          ReportsTile(reports: records),
                          const SizedBox(
                            width: 10,
                          ),
                          ExpTile(years: exp),
                          const SizedBox(
                            width: 10,
                          ),
                          RatingTile(stars: rating)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text("About",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 15)),
              const SizedBox(
                height: 5,
              ),
              Text(
                about,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: MediaQuery.of(context).size.width / 25),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff1D3092).withOpacity(.49),
                        borderRadius: BorderRadius.circular(30)),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Center(
                      child: Text(
                        "Request report",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 20),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
