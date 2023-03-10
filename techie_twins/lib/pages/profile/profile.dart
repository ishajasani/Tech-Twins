import 'package:flutter/material.dart';
import 'package:techie_twins/widgets/custom_transaction_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
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
                Text(
                  "0xff0000000000000",
                  style: TextStyle(
                      color: Colors.black.withOpacity(.5), fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Your Matic balance",
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
                      "0.00 Matic",
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
