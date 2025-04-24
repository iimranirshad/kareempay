import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
class ApplicationFields extends StatelessWidget {
  final String label;
  int lines;
  String suffix;
  final TextInputType inputType;
  final TextEditingController controller;
 ApplicationFields({super.key,required this.label,this.suffix = '',this.lines = 1,required this.inputType,required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: TextFormField(
        controller: controller,
        maxLines: lines,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.none,
        obscureText:false,
        autofocus: false,
        style: GoogleFonts.poppins(fontSize: 18.sp),
        keyboardType:inputType,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          fillColor: Color(0xffD3D3D3),
          filled: true,
          label: Text(
            label,
          ),
          labelStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey,),
          suffixText: suffix,
          suffixStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey,),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(2.h)),
        ),
      ),
    );
  }
}
