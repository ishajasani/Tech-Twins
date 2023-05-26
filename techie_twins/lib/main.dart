import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:techie_twins/mobile/pages/onboarding.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:techie_twins/web/doctor/pages/home/home.dart';
import 'package:techie_twins/web/doctor/onboarding_doctor.dart';
import 'package:techie_twins/mobile/pages/home/home.dart';
import 'package:techie_twins/web/laboratory/onboarding_laboratory.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MedVault",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme()),
        home: const WebLab(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MedVault",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme()),
        home: const Mobile(),
      );
    }
  }
}

class WebDoctor extends StatefulWidget {
  const WebDoctor({super.key});

  @override
  State<WebDoctor> createState() => _WebDoctorState();
}

class _WebDoctorState extends State<WebDoctor> {
  bool isLoggedin = false;

  @override
  void initState() {
    checkLogged();
    super.initState();
  }

  String privatekey = "";
  WalletService walletService = WalletService();
  checkLogged() async {
    privatekey = await walletService.getPrivateKey();
    if (privatekey != "") {
      setState(() {
        isLoggedin = true;
      });
    } else {
      setState(() {
        isLoggedin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedin
          ? Home(
              docAddress: EthPrivateKey.fromHex(privatekey).address,
            )
          : const OnBoardingWeb(),
    );
  }
}

class WebLab extends StatefulWidget {
  const WebLab({super.key});

  @override
  State<WebLab> createState() => _WebLabState();
}

class _WebLabState extends State<WebLab> {
  bool isLoggedin = false;

  @override
  void initState() {
    checkLogged();
    super.initState();
  }

  String privatekey = "";
  WalletService walletService = WalletService();
  checkLogged() async {
    privatekey = await walletService.getPrivateKey();
    if (privatekey != "") {
      setState(() {
        isLoggedin = true;
      });
    } else {
      setState(() {
        isLoggedin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedin
          ? Home(
              docAddress: EthPrivateKey.fromHex(privatekey).address,
            )
          : const OnBoardingLab(),
    );
  }
}

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  bool isLoggedin = false;

  @override
  void initState() {
    checkLogged();
    super.initState();
  }

  String privatekey = "";
  WalletService walletService = WalletService();
  checkLogged() async {
    privatekey = await walletService.getPrivateKey();
    if (privatekey != "") {
      setState(() {
        isLoggedin = true;
      });
    } else {
      setState(() {
        isLoggedin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedin ? const HomeMobile() : const OnBoarding(),
    );
  }
}
