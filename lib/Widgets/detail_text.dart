import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
class DetailText extends StatelessWidget {
  final String title;
  const DetailText({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Text(title,style: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: secondary,
    ),);
  }
}
