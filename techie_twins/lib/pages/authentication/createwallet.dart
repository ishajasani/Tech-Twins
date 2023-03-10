import 'package:flutter/material.dart';
import 'package:techie_twins/pages/authentication/authenticatewallet.dart';
import 'package:techie_twins/pages/authentication/newwallet.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';
class CreateWallet extends StatelessWidget {
  const CreateWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img3.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text("Create your wallet.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 7,
                          fontWeight: FontWeight.bold)),
                  Text(
                      "We need your wallet access in order to sign transactions.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.5),
                        fontSize: 20,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                    text: "I have private key",
                    onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthenticateWallet())),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButtonWhite(
                      text: "Create new one",
                      onPress: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewWallet()))),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )));
  }
}
