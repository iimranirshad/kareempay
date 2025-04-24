import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
class TermsAndConditions extends StatelessWidget {
  final String term;
  const TermsAndConditions({super.key,required this.term});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Icon(Icons.check,color: Colors.black,),
    SizedBox(width: 1.w,),
    Text(term,style: GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    ),)]);
  }
}
