import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/web/pages/home/home.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';
import 'package:techie_twins/widgets/custom_textfields.dart';

class AuthenticateWalletDoctor extends StatefulWidget {
  const AuthenticateWalletDoctor({super.key});

  @override
  State<AuthenticateWalletDoctor> createState() =>
      _AuthenticateWalletDoctorState();
}

class _AuthenticateWalletDoctorState extends State<AuthenticateWalletDoctor> {
  TextEditingController keyController = TextEditingController();
  handleLogin() async {
    bool isValid = await WalletProvider().initializeFromKey(keyController.text);
    if (isValid) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      if (kDebugMode) {
        print("Invalid Key");
      }
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
