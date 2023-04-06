import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techie_twins/config/contract_linking.dart';
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
  // ContractLinking contractLinking = ContractLinking();
  sendData() {}

  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
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
                  labelText: "Gender")
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
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                weightController.text.isNotEmpty &&
                heightController.text.isNotEmpty &&
                bloodController.text.isNotEmpty &&
                ageController.text.isNotEmpty &&
                genderController.text.isNotEmpty) {
              contractLinking.regUser(
                  nameController.text,
                  ageController.text,
                  heightController.text,
                  weightController.text,
                  genderController.text,
                  "",
                  "",
                  "");
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
