import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:sizer/sizer.dart';
class UserButton extends StatelessWidget {
  final Color color;
  final String text;
  final Color text_color;
  final double height;
  final double width;
  double border;
  bool flag;
  final VoidCallback? onTap;
  UserButton({super.key,required this.color,required this.text,required this.text_color,required this.height,required this.width,this.flag=false,this.border=3,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
        height: height.h,
        width: width.h,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(border.h))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: text_color,
                ),
              ),
            ),
            flag==true?Row(
              children: [
                Container(
                  height: 4.h,
                  width: 9.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.h)
                  ),
                  child: Center(
                    child: Icon(Icons.arrow_forward_ios,color: primary,),
                  ),
                ),

              ],
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}
