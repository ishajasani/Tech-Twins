import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/patient_contract_linking.dart';
import 'package:techie_twins/config/ipfs_service.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';
import 'package:techie_twins/widgets/custom_textfields.dart';

class EditDetails extends StatefulWidget {
  const EditDetails({super.key});

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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

  PatientContractLinking contractLinking = PatientContractLinking();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                        fontSize: MediaQuery.of(context).size.width / 10),
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
                  controller: weightController,
                  hintText: "78KG",
                  labelText: "Weight"),
              const SizedBox(
                height: 10,
              ),
              HeightField(
                  controller: heightController,
                  hintText: "5.6",
                  labelText: "Height"),
              const SizedBox(
                height: 10,
              ),
              BloodField(
                  controller: bloodController,
                  hintText: "B+",
                  labelText: "Blood group"),
              const SizedBox(
                height: 10,
              ),
              AgeField(
                  controller: ageController, hintText: "21", labelText: "Age"),
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
                  controller: phoneController,
                  hintText: "1234567890",
                  labelText: "Phone"),
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
                weightController.text.isNotEmpty &&
                heightController.text.isNotEmpty &&
                bloodController.text.isNotEmpty &&
                ageController.text.isNotEmpty &&
                genderController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                phoneController.text.isNotEmpty &&
                path != "") {
              IpfsService ipfsService = IpfsService();
              String cid = await ipfsService.uploadImage(path);
              if (kDebugMode) {
                print(cid);
              }
              contractLinking
                  .regUser(
                      nameController.text,
                      bloodController.text,
                      ageController.text,
                      heightController.text,
                      weightController.text,
                      genderController.text,
                      emailController.text,
                      phoneController.text,
                      cid)
                  .then((value) => Navigator.pop(context));
            }
            // ignore: use_build_context_synchronously
          },
          label: const Text(
            "Save",
            style: TextStyle(color: Colors.black, fontSize: 16),
          )),
    );
  }
}
