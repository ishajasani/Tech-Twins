import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techie_twins/constants.dart';
import 'package:techie_twins/mobile/pages/consultant/pick_a_consultant.dart';
import 'package:techie_twins/mobile/pages/home/home.dart';
import 'package:techie_twins/mobile/pages/laboratories/pick_a_labs.dart';
import 'package:techie_twins/mobile/pages/profile/paitent_profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomeMobile(),
          PickALab(),
          PickAConsultant(),
          PaitentProfile(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.transparent,
        border: Border.all(style: BorderStyle.none),
        items: [
          BottomNavigationBarItem(
            backgroundColor: _page == 0 ? webContainerBlue : Colors.black,
            icon: Icon(
              Icons.home,
              color: _page == 0 ? webContainerBlue : Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: _page == 1 ? webContainerBlue : Colors.black,
            icon: Icon(
              Icons.contact_page,
              color: _page == 1 ? webContainerBlue : Colors.black,
            ),
            label: 'Laboratory',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.medical_information,
              color: _page == 2 ? webContainerBlue : Colors.black,
            ),
            label: 'Consult',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 3 ? webContainerBlue : Colors.black,
            ),
            label: 'Profile',
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
