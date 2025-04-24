import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
class HomeOptionContainer extends StatelessWidget {
  final String title;
  final Widget widget;
  const HomeOptionContainer({super.key,required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 8.h,
          width: 20.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(1.h))
          ),
          child: Center(
            child: widget,
          ),
        ),
        SizedBox(height: 1.h,),
        Text(title,style: GoogleFonts.poppins(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),)
      ],
    );
  }
}
