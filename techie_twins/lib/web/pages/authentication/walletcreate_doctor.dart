import 'package:flutter/material.dart';
import 'package:techie_twins/web/pages/authentication/authenticatewallet_doctor.dart';
import 'package:techie_twins/web/pages/authentication/newwallet_doctor.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';

class WalletCreateDoctor extends StatelessWidget {
  const WalletCreateDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create your wallet.",
                      style: TextStyle(
                          height: 1,
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 20,
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
                            builder: (context) => const AuthenticateWalletDoctor())),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButtonWhite(
                      text: "Create new one",
                      onPress: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewWalletDoctor()))),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            )));
  }
}
