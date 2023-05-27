import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techie_twins/config/contract_linking/patient_contract_linking.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/mobile/pages/home/home.dart';
import 'package:techie_twins/mobile/pages/profile/edit_details.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';
import 'package:techie_twins/widgets/custom_textfields.dart';
import 'package:web3dart/web3dart.dart';

class AuthenticateWallet extends StatefulWidget {
  const AuthenticateWallet({super.key});

  @override
  State<AuthenticateWallet> createState() => _AuthenticateWalletState();
}

class _AuthenticateWalletState extends State<AuthenticateWallet> {
  TextEditingController keyController = TextEditingController();
  WalletService walletService = WalletService();
  PatientContractLinking contractLinking = PatientContractLinking();
  bool isLoading = false;
  handleLogin() async {
    setState(() {
      isLoading = true;
    });
    bool isValid = await WalletProvider().initializeFromKey(keyController.text);
    
    if (isValid) {
      EthereumAddress address =
          EthPrivateKey.fromHex(keyController.text).address;
      contractLinking.getUserData(address).then((value) {
        if (value[0] != "") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeMobile()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const EditDetails()));
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Enter a valid private key");
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/img3.jpg"),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.darken),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width / 7,
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
                        DefaultButtonWhite(
                            text: "Verify", onPress: handleLogin),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )));
  }
}
