import 'package:flutter/material.dart';
import 'package:techie_twins/widgets.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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
              const SizedBox(
                height: 100,
              ),
              DefaultButton(
                onPress: () {
                  // print("Get started");
                },
                text: 'Get started',
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}
