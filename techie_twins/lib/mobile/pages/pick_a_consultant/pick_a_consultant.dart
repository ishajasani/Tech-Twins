import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/doctor_contract_linking.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/mobile/pages/consultant/consultant_profile.dart';
import 'package:techie_twins/mobile/pages/profile/paitent_profile.dart';
import 'package:techie_twins/widgets/custom_tiles.dart';
import 'package:web3dart/web3dart.dart';

class PickAConsultant extends StatefulWidget {
  const PickAConsultant({super.key});

  @override
  State<PickAConsultant> createState() => _PickAConsultantState();
}

class _PickAConsultantState extends State<PickAConsultant> {
  @override
  void initState() {
    getDoctorsList();
    super.initState();
  }

  DoctorContractLinking contractLinking = DoctorContractLinking();
  List<dynamic> val = List.empty(growable: true);
  List addresses = List.empty(growable: true);

  int countDocs = 0;
  void getDoctorsList() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      contractLinking.getDoctorAdd().then((value) {
        for (var element in value) {
          for (var ele in element) {
            addresses.add(ele);
            contractLinking.getDoctorData(ele).then((value) {
              setState(() {
                val.add(value);
              });
            });
            setState(() {
              countDocs++;
            });
          }
        }
      });
    });
  }

  List<ConsultantTile>? tile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    "pick a consultant",
                    style: TextStyle(
                        height: 1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 10),
                  )),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: countDocs,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (val.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      String docImageUrl = ipfsURL + val[index][8];

                      return ConsultantTile(
                          designation: val[index][1],
                          exp: val[index][3],
                          name: val[index][0],
                          stars: val[index][5],
                          imageUrl: docImageUrl,
                          onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConsultantProfile(
                                              address: addresses[index],
                                            )))
                              });
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
              heroTag: "BTN1",
              icon: const Icon(Icons.home_outlined),
              onPressed: () => Navigator.pop(context),
              label: const Text("Home")),
          FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.black.withOpacity(.2),
            heroTag: "BTN2",
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PaitentProfile())),
            child: const Icon(Icons.person_2_outlined),
          )
        ],
      ),
    );
  }
}
