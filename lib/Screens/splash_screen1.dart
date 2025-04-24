import 'package:flutter/material.dart';
import 'package:karim_pay/Screens/splash_screen2.dart';

import '../Constants/constants.dart';
import '../Widgets/logo_image.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const SplashScreen2(),
          duration: const Duration(milliseconds: 800),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: user_white,
      body: const Center(
        child: LogoImage(),
      ),
    );
  }
}
