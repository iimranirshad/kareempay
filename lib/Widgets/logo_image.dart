import 'package:flutter/material.dart';
class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage('assets/images/logo.png'));
  }
}
