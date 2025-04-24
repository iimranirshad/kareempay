import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:sizer/sizer.dart';

class CustomCheckboxTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;

  const CustomCheckboxTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 13.sp,
          color: secondary,
          fontWeight: FontWeight.w400
        )
      ),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.white,
      checkColor: Colors.black,
    );
  }
}
