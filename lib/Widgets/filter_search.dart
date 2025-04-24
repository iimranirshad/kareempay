import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class FilterTextField extends StatelessWidget {
  final String hintText;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool showCalendar;
  final TextEditingController? controller;
  const FilterTextField({
    super.key,
    required this.hintText,
    this.readOnly = false,
    this.onTap,
    this.showCalendar = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      height: 4.h,
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        onTap: onTap,
        style: GoogleFonts.poppins(
          fontStyle: FontStyle.italic,
          fontSize: 11.sp,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
            fontSize: 11.sp,
          ),
          filled: true,
          fillColor: const Color(0xFFD8EAD2), // Light green
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
          suffixIcon: showCalendar
              ? Icon(Icons.calendar_today, color: Colors.grey, size: 18)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
