import 'package:flutter/material.dart';

class AppointmentAcceptence extends StatefulWidget {
  const AppointmentAcceptence({super.key});

  @override
  State<AppointmentAcceptence> createState() => AppointmentAcceptenceState();
}

class AppointmentAcceptenceState extends State<AppointmentAcceptence> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Appointment Acceptence'),
      ),
    );
  }
}
