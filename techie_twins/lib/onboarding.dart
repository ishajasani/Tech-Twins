import 'package:flutter/material.dart';
import 'package:techie_twins/pages/authentication/createwallet.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';

import 'config/walletprovider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  WalletProvider? _walletProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "The Right Choice for your Health Care Needs",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset("assets/img2.png"),
              Image.asset("assets/img1.png"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              DefaultButton(
                onPress: () {
                  // ignore: no_leading_underscores_for_local_identifiers
                  _walletProvider!.createWallet();
                  print('hello');
                },
                // onPress: () => Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const CreateWallet())),
                text: 'Get started',
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
