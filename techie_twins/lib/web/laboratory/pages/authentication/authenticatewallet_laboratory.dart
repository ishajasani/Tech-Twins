import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techie_twins/config/contract_linking/laboratory_contract_linking.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/web/laboratory/pages/add_details.dart';
import 'package:techie_twins/web/laboratory/pages/home/home_laboratory.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';
import 'package:techie_twins/widgets/custom_textfields.dart';
import 'package:web3dart/web3dart.dart';

class AuthenticateWalletLaboratory extends StatefulWidget {
  const AuthenticateWalletLaboratory({super.key});

  @override
  State<AuthenticateWalletLaboratory> createState() =>
      _AuthenticateWalletLaboratoryState();
}

class _AuthenticateWalletLaboratoryState
    extends State<AuthenticateWalletLaboratory> {
  LaboratoryContractLinking contractLinking = LaboratoryContractLinking();
  TextEditingController keyController = TextEditingController();
  WalletProvider walletProvider = WalletProvider();
  WalletService walletService = WalletService();
  void handleLogin() async {
    bool isValid = walletProvider.initializeFromKeyLab(keyController.text);

    if (isValid) {
      contractLinking
          .getLaboratoryData(EthPrivateKey.fromHex(keyController.text).address)
          .then((value) {
        if (kDebugMode) {
          print(value);
        }
        if (value[0] == "") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  AddDetailsLaboratory(labAddress:
                            EthPrivateKey.fromHex(keyController.text).address,)));
        } else {
          walletService.getPrivateKeyLab().then((value) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeLaboratory(
                          docAddress: EthPrivateKey.fromHex(value).address,
                        )));
          });
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Enter valid private key.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img3.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Text("Enter your wallet credentials.",
                        style: TextStyle(
                            height: 1,
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 20,
                            fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text("Don't have a wallet?",
                            style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: 20,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text("Create one",
                              style: TextStyle(
                                color: Colors.white.withOpacity(.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PrivateKeyField(
                      controller: keyController,
                      hintText:
                          "39bc2eb50999a396fa6ab7ff615bef86fb4cfe9bbd5d6c42bb0668c297a2eaa6",
                      labelText: "Private key",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButtonWhite(text: "Verify", onPress: handleLogin),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )));
  }
}
