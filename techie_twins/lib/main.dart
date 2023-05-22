import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techie_twins/mobile/pages/onboarding.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:techie_twins/web/onboarding.dart';

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
        home: const OnBoardingWeb(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MedVault",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.poppinsTextTheme()),
        home: const OnBoarding(),
      );
    }
  }
}
