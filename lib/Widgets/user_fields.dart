import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
class UserFields extends StatelessWidget {
 final TextEditingController controller;
  final String error;
  final TextInputType keyboardType;
 const UserFields({super.key,required this.error,required this.controller,required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.none,
      obscureText: false,
      autofocus: false,
      style: GoogleFonts.poppins(fontSize: 1.5.h),
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: secondary,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5.h)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return error;
        }
        return null;
      },
    );
  }
}
