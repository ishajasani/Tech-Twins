import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class PaitentProfile extends StatefulWidget {
  const PaitentProfile({super.key});

  @override
  State<PaitentProfile> createState() => _PaitentProfileState();
}

class _PaitentProfileState extends State<PaitentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  "create or edit your profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 10),
                )),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 120),
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: BlurryContainer(
                        borderRadius: BorderRadius.circular(25),
                        width: MediaQuery.of(context).size.width / 3.6,
                        blur: 5,
                        color: Colors.black.withOpacity(.2),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.wallet_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Wallet",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 3.7,
                  left: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Male: 24",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 20),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          "Jackson Da Vinci",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 15),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2.5,
                  child: Row(
                    children: const [
                      HeightTile(),
                      SizedBox(
                        width: 10,
                      ),
                      WeightTile(),
                      SizedBox(
                        width: 10,
                      ),
                      BloodTile()
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.blueAccent),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Your health records",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.blueAccent),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Text(
                        "Your appointments",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blueGrey[300]!.withOpacity(.5),
          elevation: 0,
          icon: const Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          onPressed: () {},
          label: const Text(
            "Home",
            style: TextStyle(color: Colors.black,fontSize: 16),
          )),
    );
  }
}

class HeightTile extends StatelessWidget {
  const HeightTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        elevation: 1,
        width: 110,
        height: 120,
        color: Colors.black.withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Height",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              Spacer(),
              Text(
                "189",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "CM",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}

class WeightTile extends StatelessWidget {
  const WeightTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        elevation: 1,
        width: 110,
        height: 120,
        color: Colors.black.withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Weight",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              Spacer(),
              Text(
                "77",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "KG",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}

class BloodTile extends StatelessWidget {
  const BloodTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        elevation: 1,
        width: 110,
        height: 120,
        color: Colors.black.withOpacity(.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Blood",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              Spacer(),
              Text(
                "B",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "+VE",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ));
  }
}
