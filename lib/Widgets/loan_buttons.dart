import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class LoanButtons extends StatelessWidget {
  final String title, subtitle, detail;
  final GestureTapCallback? onTap;
  LoanButtons(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.detail,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 11.h,
        width: 40.w,
        decoration: BoxDecoration(
            color: Color(0xFF63A67F), borderRadius: BorderRadius.circular(3.h)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: detail,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'Read More',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo,
                  ),
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
