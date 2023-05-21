import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/constants.dart';
import 'package:web3dart/web3dart.dart';

import '../../../config/contract_linking/doctor_contract_linking.dart';
import '../profile/paitent_profile.dart';

class ConsultantProfile extends StatefulWidget {
  final EthereumAddress address;
  const ConsultantProfile({super.key, required this.address});

  @override
  State<ConsultantProfile> createState() => _ConsultantProfileState();
}

class _ConsultantProfileState extends State<ConsultantProfile> {
  DoctorContractLinking contractLinking = DoctorContractLinking();

  void getDoctorinfo() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      contractLinking.getDoctorData(widget.address).then((value) {
        setState(() {
          name = value[0];
          desig = value[1];
          patientTreated = value[2];
          exp = value[3];
          gender = value[4];
          rating = value[5];
          about = value[6];
          email = value[7];
          profileURL = value[8];
        });
      });
    });
  }

  String name = "";
  String profileURL = "";
  String gender = "";
  String email = "";
  String exp = "";
  String desig = "";
  String patientTreated = "";
  String rating = "";
  String about = "";
  // String
  @override
  void initState() {
    getDoctorinfo();
    super.initState();
  }

  String appintmentStatus = "not booked";
  Widget dateTimePickerWiget() {
    return DateTimePicker(
      initialValue: '',
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      dateLabelText: 'Date',
      onChanged: (val) => print(val),
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print(val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Text(
            appintmentStatus,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
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
                    "doctor's\nprofile",
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
                          image: NetworkImage(ipfsURL + profileURL),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            desig,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize:
                                    MediaQuery.of(context).size.width / 25),
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width / 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2.5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          PatientsTreatedTile(patientTreated: patientTreated),
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
                onTap: () {
                  dateTimePickerWiget();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff1D3092).withOpacity(.49),
                      borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Book Appointment",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
