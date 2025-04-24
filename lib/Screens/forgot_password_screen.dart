import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
import '../Widgets/detail_text.dart';
import '../Widgets/user_button.dart';
import '../Widgets/user_fields.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool flag = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
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
                  Text('Forgot Password',style: GoogleFonts.poppins(
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
                                Text('Reset Password?',style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: primary
                                ),),
                                SizedBox(height: 2.h,),
                                Text('Forgot your password? No worries! Just enter your email, and we’ll help you reset it in no time.',style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: secondary
                                ),),
                                SizedBox(height: 10.h,),
                                const DetailText(title: 'Enter Email Address'),
                                SizedBox(height: 1.h,),
                                UserFields(error: 'Enter Email', controller: emailController,keyboardType: TextInputType.emailAddress,),
                                SizedBox(height: 10.h,),
                                Center(
                                  child: UserButton(
                                    color: primary,
                                    text: 'Next Step',
                                    text_color: secondary,
                                    height: 6,
                                    width: 30,
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });

                                        try {
                                          await FirebaseAuth.instance
                                              .sendPasswordResetEmail(email: emailController.text.trim());

                                          setState(() {
                                            loading = false;
                                          });

                                          // Show success snackbar/dialog
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Password reset email sent! Check your inbox."),
                                              backgroundColor: Colors.green,
                                            ),
                                          );

                                          // Optional: Navigate to NewPasswordScreen if needed
                                          // Navigator.push(context, MaterialPageRoute(builder: (_) => const NewPasswordScreen()));
                                        } on FirebaseAuthException catch (e) {
                                          setState(() {
                                            loading = false;
                                          });

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(e.message ?? "Something went wrong."),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                )

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
