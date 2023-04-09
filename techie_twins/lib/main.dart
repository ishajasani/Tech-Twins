import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:techie_twins/config/contract_linking/patient_contract_linking.dart';
import 'package:techie_twins/mobile/pages/onboarding.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:techie_twins/web/pages/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return ChangeNotifierProvider(
        create: (context) => PatientContractLinking(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Dapp",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.poppinsTextTheme()),
          home: const OnBoardingWeb(),
        ),
      );
    } else {
      return ChangeNotifierProvider(
        create: (context) => PatientContractLinking(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Dapp",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.poppinsTextTheme()),
          home: const OnBoarding(),
        ),
      );
    }
  }
}
