import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Screens/home_screen.dart';
import 'package:karim_pay/Screens/notification_screen.dart';
import 'package:karim_pay/Screens/profile_update.dart';
import 'package:karim_pay/Widgets/notification_model.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  bool? flag;
  BottomNavBar({super.key, this.flag});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    bool invertedFlag = !(widget.flag ?? false);
    super.initState();
    _screens = [
      HomeScreen(flag: invertedFlag),
      // HomeScreen(flag: widget.flag),
      NotificationScreen(),
      ProfileUpdate(),
    ];

    // Set initial screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Color(0xFF052405),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: Text("Home", style: GoogleFonts.poppins()),
            selectedColor: Color(0xFF63A67F),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.notifications),
            title: Text("Notifications", style: GoogleFonts.poppins()),
            selectedColor: const Color(0xFF63A67F),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: Text("Profile", style: GoogleFonts.poppins()),
            selectedColor: Color(0xFF63A67F),
          ),
        ],
      ),
    );
  }
}
