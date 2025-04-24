import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
import '../Widgets/detail_text.dart';
import '../Widgets/user_button.dart';
class SecurityPinScreen extends StatefulWidget {
  const SecurityPinScreen({super.key});

  @override
  State<SecurityPinScreen> createState() => _SecurityPinScreenState();
}

class _SecurityPinScreenState extends State<SecurityPinScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h,),
            Container(
              color: primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Security Pin',style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                    color: secondary,
                  ),textAlign: TextAlign.center,),
                  SizedBox(height: 5.h,),
                  Container(
                    width: double.infinity,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.h),
                        topRight: Radius.circular(6.h),
                      ),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.h),
                      child: Column(
                        children: [
                          SizedBox(height: 10.h,),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.h,),
                                const Center(child: DetailText(title: 'Enter Security Pin')),
                                SizedBox(height: 10.h,),
                                PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.circle,
                                    activeFillColor: secondary,
                                    inactiveColor: primary,
                                    inactiveFillColor: primary,
                                    disabledColor: primary,
                                    selectedFillColor: primary,
                                    selectedColor: secondary
                                  ),
                                  cursorColor: Colors.black,
                                  enableActiveFill: true,
                                ),
                                SizedBox(height: 10.h,),
                                Center(child: UserButton(color: primary, text: 'Accept', text_color: secondary, height: 5.5, width: 25)),
                                SizedBox(height: 3.h,),
                                Center(child: UserButton(color: secondary, text: 'Send Again', text_color: primary, height: 5.5, width: 25)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
