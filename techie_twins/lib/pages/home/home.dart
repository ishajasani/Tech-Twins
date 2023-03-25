import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/pages/profile/paitent_profile.dart';
import 'package:techie_twins/widgets/tiles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _name = 'Tom';

  //TODO: Remove extraspace from the image
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    "How are you feeling today $_name?",
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
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        "A healthy outside starts from the inside.- Robert Urich",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
              color: bottomNavigationBarColor.withOpacity(.2),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.black.withOpacity(.2),
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.monitor_heart_outlined,
                    color: Colors.black.withOpacity(.2),
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.local_hospital_outlined,
                    color: Colors.black.withOpacity(.2),
                    size: 30,
                  )),
              IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> PaitentProfile())),
                  icon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.black.withOpacity(.2),
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
