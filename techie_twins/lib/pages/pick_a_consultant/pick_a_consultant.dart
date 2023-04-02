import 'package:flutter/material.dart';
import 'package:techie_twins/widgets/custom_tiles.dart';

class PickAConsultant extends StatefulWidget {
  const PickAConsultant({super.key});

  @override
  State<PickAConsultant> createState() => _PickAConsultantState();
}

class _PickAConsultantState extends State<PickAConsultant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "pick a consultant",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 10),
                  )),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ConsultantTile(
                      designation: 'Therapist',
                      exp: '9',
                      name: 'Dr. Julie Serenil',
                      stars: '5.0',
                      imageUrl: '',
                      onTap: () {},
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
              heroTag: "BTN1",
              icon: const Icon(Icons.home_outlined),
              onPressed: () {},
              label: const Text("Home")),
          FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.black.withOpacity(.2),
            heroTag: "BTN2",
            onPressed: () {},
            child: const Icon(Icons.person_2_outlined),
          )
        ],
      ),
    );
  }
}
