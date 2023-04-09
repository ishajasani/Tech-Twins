import 'package:flutter/material.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/web/pages/authentication/walletcreate_doctor.dart';

class OnBoardingWeb extends StatefulWidget {
  const OnBoardingWeb({super.key});

  @override
  State<OnBoardingWeb> createState() => _OnBoardingWebState();
}

class _OnBoardingWebState extends State<OnBoardingWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.4,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: webContainerColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: MediaQuery.of(context).size.width / 20),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        "Secure Diagosnistic System",
                        style: TextStyle(
                            height: 1.1,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 20),
                      ),
                    ),
                    Image(
                        width: MediaQuery.of(context).size.width / 5,
                        image: const AssetImage('assets/logo.png'))
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 70, right: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "tech by",
                        style: TextStyle(
                            height: 1,
                            fontSize: MediaQuery.of(context).size.width / 50,
                            color: Colors.black54),
                      ),
                      Text(
                        "Techie",
                        style: TextStyle(
                            height: 1,
                            fontSize: MediaQuery.of(context).size.width / 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "Twins",
                        style: TextStyle(
                            height: 1,
                            fontSize: MediaQuery.of(context).size.width / 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Image(
                        width: MediaQuery.of(context).size.width / 5,
                        image: const AssetImage('assets/heart.png'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 16,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: webContainerBlue),
            child: Center(
              child: Text(
                "Experience the future of healthcare management with our cutting-edge technology",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 50),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(300, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      side: const BorderSide(width: 2, color: Colors.black),
                    ),
                    onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  const WalletCreateDoctor())),
                        ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    )),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Text(
                    "When creativity meets technology",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        height: 1,
                        fontSize: MediaQuery.of(context).size.width / 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
