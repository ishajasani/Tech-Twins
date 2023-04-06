import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:techie_twins/config/contract_linking.dart';
import 'package:techie_twins/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context)=> ContractLinking(),
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
