import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techie_twins/config/patient_contract_linking.dart';
import 'package:techie_twins/config/ipfs_service.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';
import 'package:techie_twins/widgets/custom_textfields.dart';

class EditDetailsDoctor extends StatefulWidget {
  const EditDetailsDoctor({super.key});

  @override
  State<EditDetailsDoctor> createState() => _EditDetailsDoctorState();
}

class _EditDetailsDoctorState extends State<EditDetailsDoctor> {
  TextEditingController nameController = TextEditingController();
  TextEditingController patientCountController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  String path = "";
  bool isSelected = false;
  pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      path = file.path;
      if (kDebugMode) {
        print(file.path);
      }
      setState(() {
        isSelected = true;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<PatientContractLinking>(context);
    return Scaffold(
      body: Container(
        margin:  EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 3),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    "edit your profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 20),
                  )),
              const SizedBox(
                height: 20,
              ),
              NameField(
                  controller: nameController,
                  hintText: "Jackson Da Vinchi",
                  labelText: "Name"),
              const SizedBox(
                height: 10,
              ),
              WeightField(
                  controller: patientCountController,
                  hintText: "123+",
                  labelText: "Patient treated"),
              const SizedBox(
                height: 10,
              ),
              HeightField(
                  controller: expController,
                  hintText: "5+",
                  labelText: "Experience"),
              const SizedBox(
                height: 10,
              ),
              BloodField(
                  controller: bloodController,
                  hintText: "4 Stars",
                  labelText: "Ratings"),
              const SizedBox(
                height: 10,
              ),
              GenderField(
                  controller: genderController,
                  hintText: "Male",
                  labelText: "Gender"),
              const SizedBox(
                height: 10,
              ),
              PhoneField(
                  controller: aboutController,
                  hintText: "asefasf",
                  labelText: "About"),
              const SizedBox(
                height: 10,
              ),
              EmailField(
                  controller: emailController,
                  hintText: "example@gmail.com",
                  labelText: "Email"),
              const SizedBox(
                height: 10,
              ),
              DefaultButton(
                  text: "Image Selected: $isSelected",
                  onPress: () async {
                    await pickFiles();
                  }),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "1",
          backgroundColor: Colors.blueGrey[300]!.withOpacity(.5),
          elevation: 0,
          icon: const Icon(
            Icons.save_as_outlined,
            color: Colors.black,
          ),
          onPressed: () async {
            if (nameController.text.isNotEmpty &&
                patientCountController.text.isNotEmpty &&
                expController.text.isNotEmpty &&
                bloodController.text.isNotEmpty &&
                ageController.text.isNotEmpty &&
                genderController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                aboutController.text.isNotEmpty &&
                path != "") {
              IpfsService ipfsService = IpfsService();
              String cid = await ipfsService.uploadImage(path);
              print(cid);
              contractLinking.regUser(
                  nameController.text,
                  bloodController.text,
                  ageController.text,
                  expController.text,
                  patientCountController.text,
                  genderController.text,
                  emailController.text,
                  aboutController.text,
                  cid);
            }
            Navigator.pop(context);
          },
          label: const Text(
            "Save",
            style: TextStyle(color: Colors.black, fontSize: 16),
          )),
    );
  }
}
