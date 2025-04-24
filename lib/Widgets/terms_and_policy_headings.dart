import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:sizer/sizer.dart';
class TermsAndPolicyHeadings extends StatelessWidget {
  final String title;
  final IconData data;
  Color color;
  double angle;
 TermsAndPolicyHeadings({super.key,required this.title,required this.data,this.color = Colors.brown,this.angle=0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(angle: angle,child:Icon(data,color: color,size: 4.h,),),
        SizedBox(width: 0.5.h,),
        Text(title,style: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: secondary,
        ),),
      ],
    );
  }
}
