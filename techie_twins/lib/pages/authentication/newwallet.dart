import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/pages/home/home.dart';
import 'package:techie_twins/widgets/custom_buttons.dart';

class NewWallet extends StatefulWidget {
  const NewWallet({super.key});

  @override
  State<NewWallet> createState() => NewWalletState();
}

class NewWalletState extends State<NewWallet> {
  WalletProvider? _walletProvider;
  // _walletProvider?.createWallet();
  @override
  void initState() {
    _walletProvider?.createWallet();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.network(
                'https://assets6.lottiefiles.com/private_files/lf30_p9aibugk.json'),
            const SizedBox(
              height: 20,
            ),
            const Text('Congratulations',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text('Account created',
                style: TextStyle(
                  color: Colors.white.withOpacity(.5),
                  fontSize: 20,
                )),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Public address',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                    fontSize: 20,
                  )),
            ),
            Row(
              children: [
                Text("0xff0000000000000",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.content_copy_rounded,
                      color: Colors.white.withOpacity(.6),
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Wallet Balance',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                    fontSize: 20,
                  )),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text("0.000 MATIC",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            DefaultButtonWhite(text: "Get some fresh Matic", onPress: () {}),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Home())),
                child: const Text(
                  "Skip for now!!",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 20),
                ))
          ],
        ),
      ),
    ));
  }
}
