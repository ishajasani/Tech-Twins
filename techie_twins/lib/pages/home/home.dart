import 'package:flutter/material.dart';
import 'package:techie_twins/pages/profile/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage())),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ],
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: const Center(child: Text("This is the home page")));
  }
}
