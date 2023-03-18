import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';
import 'package:techie_twins/widgets/custom_textfields.dart';

class AuthenticateWallet extends StatelessWidget {
  const AuthenticateWallet({super.key});

  @override
  Widget build(BuildContext context) {
    WalletProvider walletProvider = WalletProvider();
    TextEditingController keyController = TextEditingController();
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
                    WalletAddressTextField(
                      controller: keyController,
                      hintText: "asdfasdfasfasfdfas",
                      labelText: "Private key",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    WalletPinTextField(
                      controller: TextEditingController(),
                      hintText: "******",
                      labelText: "Wallet pin",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButtonWhite(
                        text: "Verify",
                        onPress: () async {
                          
                         await walletProvider.initializeWallet(keyController.text);
                            print("object");
                         
                        }),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )));
  }
}
