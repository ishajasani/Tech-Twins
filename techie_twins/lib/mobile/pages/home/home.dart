import 'dart:convert';
import 'dart:math';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/mobile/pages/consultant/pick_a_consultant.dart';
import 'package:techie_twins/mobile/pages/profile/paitent_profile.dart';
import 'package:techie_twins/widgets/custom_tiles.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({super.key});

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  bool isLoading = false;
  int randomNumber = 0;
  @override
  void initState() {
    decodeJson();
    super.initState();
  }

  // ignore: prefer_typing_uninitialized_variables
  var quote;
  void decodeJson() async {
    setState(() {
      isLoading = true;
    });
    final json = await rootBundle.loadString('assets/json/quotes.json');
    final data = await jsonDecode(json);
    setState(() {
      quote = data;
      randomNumber = Random().nextInt(1643);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset('assets/female_doctor.png')),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          "How are you feeling today?",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const DoctorTileBlue(),
                      const SizedBox(
                        height: 30,
                      ),
                      const DoctorTileRed(),
                      const SizedBox(
                        height: 30,
                      ),
                      BlurryContainer(
                        blur: 5,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 6,
                        elevation: 0,
                        color: Colors.grey.withOpacity(.2),
                        padding: const EdgeInsets.all(8),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Center(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                "${quote[randomNumber]['text']} - ${quote[randomNumber]['author']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
