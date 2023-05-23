import 'package:flutter/material.dart';

class YourPatients extends StatefulWidget {
  const YourPatients({super.key});

  @override
  State<YourPatients> createState() => _YourPatientsState();
}

class _YourPatientsState extends State<YourPatients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemBuilder: ((context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80')),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        "David",
                        style: TextStyle(
                            color: Colors.white,
                            height: 1,
                            fontSize: MediaQuery.of(context).size.width / 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "David",
                            style: TextStyle(
                                color: Colors.white,
                                height: 1,
                                fontSize:
                                    MediaQuery.of(context).size.width / 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text("Male:24",
                              style: TextStyle(
                                  color: Colors.white,
                                  height: 1,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 60,
                                  fontWeight: FontWeight.normal))
                        ],
                      )
                    ],
                  ),
                );
              })),
        ),
      ],
    ));
  }
}
