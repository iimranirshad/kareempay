import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
class HomeContainers extends StatelessWidget {
  final String title,amount;
  final Widget widget1,widget2;
  const HomeContainers({super.key,required this.title,required this.amount,required this.widget1,required this.widget2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.h,
      width: 40.w,
      decoration: BoxDecoration(
          color: user_white,
          borderRadius: BorderRadius.all(Radius.circular(3.h))
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h,vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image(image: AssetImage('assets/images/Salary.png'),height: 1.5.h,),
                SizedBox(width: 0.5.w,),
                Icon(Icons.outbond_outlined,color: primary,size: 1.5.h,),
                Text(title,style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: primary,
                  fontWeight: FontWeight.w400,
                ),),

              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.5.h),
              child: Text(amount,style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: primary
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.5.h),
              child: widget1,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.5.h),
              child: widget2,
            )
          ],
        ),
      ),
    );
  }
}
