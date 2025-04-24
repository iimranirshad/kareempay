import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const ProfileWidget({super.key,required this.icon,required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 8.h,
          width: 18.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.h)
          ),
          child: Icon(icon,size: 5.h,),
        ),
        SizedBox(width: 8.w,),
        Text(title,style: GoogleFonts.poppins(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: secondary
        ),),
      ],
    );
  }
}
