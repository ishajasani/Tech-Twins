import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/config/contract_linking/laboratory_contract_linking.dart';
import 'package:techie_twins/config/ipfs_service.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/web/laboratory/pages/home/home_laboratory.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';
import 'package:techie_twins/widgets/custom_textfields.dart';
import 'package:web3dart/web3dart.dart';

class AddDetailsLaboratory extends StatefulWidget {
  const AddDetailsLaboratory({
    super.key,
  });

  @override
  State<AddDetailsLaboratory> createState() => _AddDetailsLaboratoryState();
}

class _AddDetailsLaboratoryState extends State<AddDetailsLaboratory> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reportsCountController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  // TextEditingController ageController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  late Uint8List path;
  bool isSelected = false;
  pickFiles() async {
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles();

      if (result != null) {
        Uint8List? bytes = result.files.single.bytes;

        if (kDebugMode) {
          print('=========================================');
        }
        setState(() {
          path = bytes!;
        });
        if (kDebugMode) {
          print(bytes!.length);
        }
        setState(() {
          isSelected = true;
        });
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  LaboratoryContractLinking contractLinking = LaboratoryContractLinking();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
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
                        height: 1,
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
                  controller: reportsCountController,
                  hintText: "123+",
                  labelText: "Reports generated"),
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
                  controller: ratingController,
                  hintText: "4 Stars",
                  labelText: "Ratings"),
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
      floatingActionButton: TextButton(
        onPressed: () async {
          String privatekey = await WalletService().getPrivateKeyLab();
          if (nameController.text.isNotEmpty &&
                  reportsCountController.text.isNotEmpty &&
                  expController.text.isNotEmpty &&
                  ratingController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  aboutController.text.isNotEmpty
              // && path != ""
              ) {
            IpfsService ipfsService = IpfsService();
            String cid = await ipfsService.uploadImageWeb(path);
            if (kDebugMode) {
              print(cid);
            }
            contractLinking
                .regLaboratory(
                    nameController.text,
                    reportsCountController.text,
                    expController.text,
                    ratingController.text,
                    emailController.text,
                    aboutController.text,
                    cid)
                .then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => HomeLaboratory(
                            docAddress:
                                EthPrivateKey.fromHex(privatekey).address)))));
          }
          // ignore: use_build_context_synchronously
        },
        child: Text(
          "proceed",
          style: TextStyle(
              height: 1,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width / 20),
        ),
      ),
    );
  }
}
