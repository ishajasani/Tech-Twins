import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:techie_twins/onboarding.dart';
import 'package:techie_twins/pages/authentication/authenticatewallet.dart';

import 'config/contractLinking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (context) => ContractLinking(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Dapp",
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   textTheme: GoogleFonts.poppinsTextTheme()),
        home: AuthenticateWallet(),
      ),
    );
  }
}
