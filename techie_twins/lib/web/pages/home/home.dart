import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/constants.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  double accountBalance = 0;
  WalletProvider walletProvider = WalletProvider();

  getUserData() async {
    await walletProvider.initializeWallet();
    EtherAmount etherAmount = await Web3Client(rpcUrl, Client()).getBalance(
        EthereumAddress.fromHex(walletProvider.ethereumAddress!.hex));
    accountBalance = etherAmount.getInEther.toDouble();

    if (kDebugMode) {
      print("Balance: $accountBalance");
      print(walletProvider.ethereumAddress);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: Text(
                "doctor profile",
                style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              // margin: const EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width / 4.5,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"))),
            ),
            Text(
              "Your balance",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "$accountBalance ETH",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1,
                  fontSize: MediaQuery.of(context).size.width / 20),
            ),
          ],
        ),
      ),
    );
  }
}
