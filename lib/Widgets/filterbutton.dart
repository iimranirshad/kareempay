import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class FilterSearchButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height;
  final double width;
  final String title;
  final double fontsize;
  const FilterSearchButton({super.key, required this.onPressed,required this.height,required this.width, required this.title, required this.fontsize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3E9C4F), // Green
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.w),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: fontsize,
          ),
        ),
      ),
    );
  }
}
