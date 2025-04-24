// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:karim_pay/Screens/home_screen.dart';
// import 'package:karim_pay/Screens/logIn_screen.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:sizer/sizer.dart';

// import '../Constants/constants.dart';
// import '../Widgets/detail_text.dart';
// import '../Widgets/user_button.dart';
// import '../Widgets/user_fields.dart';
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   bool obscure = true;
//   bool c_obscure = true;
//   void handleSignUp() async {
//     if (_formKey.currentState!.validate()) {
//       if (passwordController.text != c_passwordController.text) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Passwords do not match')),
//         );
//         return;
//       }

//       setState(() {
//         loading = true;
//       });

//       try {
//         // Create user with email & password
//         UserCredential userCredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(
//             email: emailController.text.trim(),
//             password: passwordController.text.trim());

//         String uid = userCredential.user!.uid;

//         // Save user details to Firestore
//         await FirebaseFirestore.instance.collection('users').doc(uid).set({
//           'full_name': textController.text.trim(),
//           'email': emailController.text.trim(),
//           'dob': dateController.text.trim(),
//           'uid': uid,
//           'created_at': Timestamp.now(),
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Account created successfully!')),
//         );
//         Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: HomeScreen(flag: true)));

//         // Optionally navigate to home or login screen
//         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
//       } on FirebaseAuthException catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.message ?? 'An error occurred')),
//         );
//       } finally {
//         setState(() {
//           loading = false;
//         });
//       }
//     }
//   }
//   bool flag = true;
//   bool loading = false;
//   final _formKey = GlobalKey<FormState>();
//   final textController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final dateController = TextEditingController();
//   final c_passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primary,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 10.h,),
//             Container(
//               color: primary,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Create Account',style: GoogleFonts.poppins(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.w500,
//                     color: secondary,
//                   ),textAlign: TextAlign.center,),
//                   SizedBox(height: 5.h,),
//                   Container(
//                     width: double.infinity,
//                     height: 80.h,
//                     decoration: BoxDecoration(
//                       color: Colors.green[400],
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(6.h),
//                         topRight: Radius.circular(6.h),
//                       ),
//                     ),
//                     child: Padding(
//                       padding:  EdgeInsets.symmetric(horizontal: 2.h),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 3.h,),
//                           Form(
//                             key: _formKey,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const DetailText(title: 'Full Name'),
//                                 SizedBox(height: 1.h,),
//                                 UserFields(error: 'Enter Name', controller: textController,keyboardType: TextInputType.text,),
//                                 SizedBox(height: 1.h,),
//                                 const DetailText(title: 'Email'),
//                                 SizedBox(height: 1.h,),
//                                 UserFields(error: 'Enter Email', controller: emailController,keyboardType: TextInputType.emailAddress,),
//                                 SizedBox(height: 1.h,),
//                                 const DetailText(title: 'Date Of Birth'),
//                                 SizedBox(height: 1.h,),
//                                 UserFields(error: 'Enter Date Of Birth', controller: dateController,keyboardType: TextInputType.datetime,),
//                                 SizedBox(height: 1.h,),
//                                 const DetailText(title: 'Password'),
//                                 SizedBox(height: 1.h,),
//                                 TextFormField(
//                                   controller: passwordController,
//                                   textAlign: TextAlign.start,
//                                   textInputAction: TextInputAction.none,
//                                   obscureText: obscure,
//                                   autofocus: false,
//                                   style: GoogleFonts.poppins(fontSize: 1.5.h),
//                                   keyboardType: TextInputType.text,
//                                   textAlignVertical: TextAlignVertical.center,
//                                   decoration: InputDecoration(
//                                     suffixIcon: GestureDetector(child: Icon( obscure ==true?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,color: primary,),onTap: (){setState(() {
//                                       obscure =!obscure;
//                                     });},),
//                                     fillColor: secondary,
//                                     filled: true,
//                                     border: OutlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         borderRadius: BorderRadius.circular(5.h)),
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Enter Password';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 1.h,),
//                                 const DetailText(title: 'Confirm Password'),
//                                 SizedBox(height: 1.h,),
//                                 TextFormField(
//                                   controller: c_passwordController,
//                                   textAlign: TextAlign.start,
//                                   textInputAction: TextInputAction.none,
//                                   obscureText: c_obscure,
//                                   autofocus: false,
//                                   style: GoogleFonts.poppins(fontSize: 1.5.h),
//                                   keyboardType: TextInputType.text,
//                                   textAlignVertical: TextAlignVertical.center,
//                                   decoration: InputDecoration(
//                                     suffixIcon: GestureDetector(child: Icon( c_obscure ==true?Icons.remove_red_eye_outlined:Icons.visibility_off_outlined,color: primary,),onTap: (){setState(() {
//                                       c_obscure =!c_obscure;
//                                     });},),
//                                     fillColor: secondary,
//                                     filled: true,
//                                     border: OutlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         borderRadius: BorderRadius.circular(5.h)),
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Confirm Password';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 1.h,),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text('By continuing, you agree to',style: GoogleFonts.poppins(
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w300,
//                                       color: secondary,
//                                     ),),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text('Terms of Use',style: GoogleFonts.poppins(
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.bold,
//                                           color: secondary,
//                                         ),),
//                                         Text(' and ',style: GoogleFonts.poppins(
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w300,
//                                           color: secondary,
//                                         ),),
//                                         Text('Privacy Policy',style: GoogleFonts.poppins(
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.bold,
//                                           color: secondary,
//                                         ),),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(height: 1.h,),
//                                 Center(child: UserButton(color: primary, text: 'Sign Up', text_color: secondary, height: 5.5, width: 25,onTap: handleSignUp,)),
//                                 SizedBox(height: 1.h,),
//                                 Center(
//                                   child: Text("Or sign up with",style: GoogleFonts.poppins(
//                                     fontSize: 14.sp,
//                                     color: secondary,
//                                     fontWeight: FontWeight.w500,
//                                   ),),
//                                 ),
//                                 SizedBox(height: 1.h,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Image(image: AssetImage('assets/images/facebook.png'),filterQuality: FilterQuality.high,),
//                                     SizedBox(width: 5.w,),
//                                     Image(image: const AssetImage('assets/images/google.png'),height: 4.h,width: 4.h,filterQuality: FilterQuality.high,)
//                                   ],
//                                 ),
//                                 SizedBox(height: 1.h,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text("Already have an account?",style: GoogleFonts.poppins(
//                                       fontSize: 16.sp,
//                                       color: secondary,
//                                       fontWeight: FontWeight.w500,
//                                     ),),
//                                     GestureDetector(
//                                       child: Text(' Log In',style: GoogleFonts.poppins(
//                                         fontSize: 16.sp,
//                                         color: primary,
//                                         fontWeight: FontWeight.w500,
//                                       ),),
//                                       onTap: (){
//                                         Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: LoginScreen()));
//                                       },
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Screens/home_screen.dart';
import 'package:karim_pay/Screens/logIn_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
import '../Widgets/detail_text.dart';
import '../Widgets/user_button.dart';
import '../Widgets/user_fields.dart';


class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
          color: Colors.black.withOpacity(0.5),
          dismissible: false,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primary),
              strokeWidth: 3.0,
            ),
          ),
        ),
      ],
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscure = true;
  bool c_obscure = true;
  bool flag = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dateController = TextEditingController();
  final c_passwordController = TextEditingController();

  void handleSignUp() async {
  if (_formKey.currentState!.validate()) {
    if (passwordController.text != c_passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Show loading overlay
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingOverlay(),
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'full_name': textController.text.trim(),
        'email': emailController.text.trim(),
        'dob': dateController.text.trim(),
        'uid': uid,
        'created_at': Timestamp.now(),
      });
      
      Navigator.pop(context); // Remove loading overlay
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: HomeScreen(flag: true),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Remove loading overlay on error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Container(
                color: primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.h),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: 80.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.h),
                          topRight: Radius.circular(6.h),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 3.h),
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const DetailText(title: 'Full Name'),
                                    SizedBox(height: 1.h),
                                    UserFields(
                                      error: 'Name must be provided',
                                      controller: textController,
                                      keyboardType: TextInputType.text,
                                    ),
                                    SizedBox(height: 1.h),
                                    const DetailText(title: 'Email'),
                                    SizedBox(height: 1.h),
                                    UserFields(
                                      error: 'Email must be provided',
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    SizedBox(height: 1.h),
                                    const DetailText(title: 'Date Of Birth'),
                                    SizedBox(height: 1.h),
                                    // UserFields(
                                    //   error: 'Date of Birth must be provided',
                                    //   controller: dateController,
                                    //   keyboardType: TextInputType.datetime,
                                    // ),
                                    GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: AbsorbPointer(
                                        child: TextFormField(
                                          controller: dateController,
                                          decoration: InputDecoration(
                                            hintText: 'Select Date of Birth',
                                            filled: true,
                                            fillColor: secondary,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5.h),
                                            ),
                                            suffixIcon: Icon(
                                                Icons.calendar_today,
                                                color: primary),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Date of Birth is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    const DetailText(title: 'Password'),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      controller: passwordController,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.none,
                                      obscureText: obscure,
                                      autofocus: false,
                                      style:
                                          GoogleFonts.poppins(fontSize: 1.5.h),
                                      keyboardType: TextInputType.text,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          child: Icon(
                                            obscure == true
                                                ? Icons.remove_red_eye_outlined
                                                : Icons.visibility_off_outlined,
                                            color: primary,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              obscure = !obscure;
                                            });
                                          },
                                        ),
                                        fillColor: secondary,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(5.h)),
                                      ),
                                      // For password field
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password must be provided'; // More formal message
                                        }
                                        if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 1.h),
                                    const DetailText(title: 'Confirm Password'),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      controller: c_passwordController,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.none,
                                      obscureText: c_obscure,
                                      autofocus: false,
                                      style:
                                          GoogleFonts.poppins(fontSize: 1.5.h),
                                      keyboardType: TextInputType.text,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        suffixIcon: GestureDetector(
                                          child: Icon(
                                            c_obscure == true
                                                ? Icons.remove_red_eye_outlined
                                                : Icons.visibility_off_outlined,
                                            color: primary,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              c_obscure = !c_obscure;
                                            });
                                          },
                                        ),
                                        fillColor: secondary,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(5.h)),
                                      ),
                                      // For confirm password field
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please confirm your password';
                                        }
                                        if (value != passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 1.h),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'By continuing, you agree to',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300,
                                            color: secondary,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Terms of Use',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: secondary,
                                              ),
                                            ),
                                            Text(
                                              ' and ',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w300,
                                                color: secondary,
                                              ),
                                            ),
                                            Text(
                                              'Privacy Policy',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: secondary,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Center(
                                      child: UserButton(
                                        color: primary,
                                        text: 'Sign Up',
                                        text_color: secondary,
                                        height: 5.5,
                                        width: 25,
                                        onTap: handleSignUp,
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Center(
                                      child: Text(
                                        "Or sign up with",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: secondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                              'assets/images/facebook.png'),
                                          filterQuality: FilterQuality.high,
                                        ),
                                        SizedBox(width: 5.w),
                                        Image(
                                          image: const AssetImage(
                                              'assets/images/google.png'),
                                          height: 4.h,
                                          width: 4.h,
                                          filterQuality: FilterQuality.high,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an account?",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            color: secondary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Text(
                                            ' Log In',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              color: primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child:
                                                        const LoginScreen()));
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            3.h), // Added extra space at bottom
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // In your _SignupScreenState class, add this method:
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
