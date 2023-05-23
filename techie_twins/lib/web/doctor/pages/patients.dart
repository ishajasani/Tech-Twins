import 'package:flutter/material.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/widgets/custom_tiles.dart';

class YourPatients extends StatefulWidget {
  const YourPatients({super.key});

  @override
  State<YourPatients> createState() => _YourPatientsState();
}

class _YourPatientsState extends State<YourPatients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your',
                        style: TextStyle(
                            height: 1,
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'patients',
                        style: TextStyle(
                            height: 1,
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                 const Spacer(),
                  TextButton(onPressed: (){}, child: Text("your profile",style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width / 50),))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.41,
                    width: MediaQuery.of(context).size.width / 3,
                    child: GridView.builder(
                        itemCount: 10,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 400,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: ((context, index) {
                          return PatientTile(
                            age: '21',
                            consultTap: () {},
                            gender: 'Male',
                            imageURL:
                                'https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80',
                            intoTap: () {},
                            name: 'David Smith',
                          );
                        })),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
