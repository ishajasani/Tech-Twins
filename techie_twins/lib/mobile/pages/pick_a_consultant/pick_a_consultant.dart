import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/doctor_contract_linking.dart';
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
  List name = [];
  List desig = [];
  List stars = [];
  List exp = [];
  List imageUrl = [];
  void getDoctorsList() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      contractLinking.getDoctorAdd().then((value) {
        for (var element in value) {
          for (var ele in element) {
            getDoctorinfo(ele);
          }
        }
      });
    });
  }

  List<ConsultantTile>? tile;
  void getDoctorinfo(EthereumAddress address) {
    contractLinking.getDoctorData(address).then((value) {
      print("-------------------------------");
      print(value[0]);
      print(value[1]);
      print(value[2]);
      print(value[3]);
      print(value[4]);
      print(value[5]);
      print(value[6]);
      print(value[7]);
      print(value[8]);
      print("-------------------------------");
    });
  }

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
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 10),
                  )),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ConsultantTile(
                      designation: 'Therapist',
                      exp: '9',
                      name: 'Dr. Julie Serenil',
                      stars: '5.0',
                      imageUrl: '',
                      onTap: () {},
                    );
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
