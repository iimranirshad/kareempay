import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:sizer/sizer.dart';
class SubHeadings extends StatelessWidget {
  final String title;
  const SubHeadings({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,style: GoogleFonts.poppins(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: secondary
    ),);
  }
}
