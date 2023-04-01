import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:techie_twins/config/walletprovider.dart';
import 'package:techie_twins/widgets/custom_transaction_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/web3dart.dart';

import '../../constants.dart';

class WalletProfile extends StatefulWidget {
  const WalletProfile({super.key});

  @override
  State<WalletProfile> createState() => _WalletProfileState();
}

class _WalletProfileState extends State<WalletProfile> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  double accountBalance = 0;
  WalletProvider walletProvider = WalletProvider();

  _openUrl(String url) async {
    await canLaunchUrl(Uri.parse(url));
    await Future.delayed(const Duration(seconds: 2));
  }

  getUserData() async {
    await walletProvider.initializeWallet();
    EtherAmount etherAmount =
        await Web3Client(rpcUrl, Client()).getBalance(
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                getUserData();
              },
              icon: const Icon(Icons.refresh_outlined))
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Tim David",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                        text: walletProvider.ethereumAddress.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Copied to clipboard'),
                    ));
                  },
                  child: Text(
                    walletProvider.ethereumAddress.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(.5), fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Your Ether balance",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.width / 11,
                        child: Image.asset('assets/matic.png')),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$accountBalance Eth",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 10),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Your transactions",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TransactionTile(
                  address: '0xff000000',
                  name: 'Jason',
                  amount: 0.9,
                ),
                const TransactionTile(
                  address: '0xff000000',
                  name: 'Jason',
                  amount: 0.9,
                ),
                const TransactionTile(
                  address: '0xff000000',
                  name: 'Jason',
                  amount: 0.9,
                ),
                const TransactionTile(
                  address: '0xff000000',
                  name: 'Jason',
                  amount: 0.9,
                ),
              ],
            )),
      ),
    );
  }
}
