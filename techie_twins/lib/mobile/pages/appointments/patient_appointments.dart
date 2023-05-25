import 'package:flutter/material.dart';

class PatientAppointments extends StatefulWidget {
  const PatientAppointments({super.key});

  @override
  State<PatientAppointments> createState() => _PatientAppointmentsState();
}

class _PatientAppointmentsState extends State<PatientAppointments> {
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
              height: 50,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  "Your appointments",
                  style: TextStyle(
                      height: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 10),
                )),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ListTile(
                    title: Text("Dr. John Doe",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("Dentist"),
                    trailing: Text("12:00 PM"),
                  );
                })
          ],
        ),
      ),
    ));
  }
}
