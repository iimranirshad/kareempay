import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:karim_pay/Screens/application_screen2.dart';
import 'package:karim_pay/Screens/profile_update.dart';
import 'package:karim_pay/Widgets/long_text.dart';
import 'package:karim_pay/Widgets/sub_headings.dart';
import 'package:karim_pay/Widgets/sub_text.dart';
import 'package:karim_pay/Widgets/terms_and_policy_headings.dart';
import 'package:karim_pay/Widgets/user_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'edit_profile.dart';
import 'notification_screen.dart';
class MurabahaScreen extends StatefulWidget {

  const MurabahaScreen({super.key,});

  @override
  State<MurabahaScreen> createState() => _MurabahaScreenState();
}

class _MurabahaScreenState extends State<MurabahaScreen> {
  Uint8List? _imageBytes;
  @override
  void initState() {
    super.initState();
    _loadUserProfileImage();
  }
  Future<void> _loadUserProfileImage() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists && doc.data()!['profileImage'] != null) {
      setState(() {
        _imageBytes = base64Decode(doc.data()!['profileImage']);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, Welcome Back',style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: secondary
            ),),
            Text('Good Morning',style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: secondary
            )),
          ],
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 3.w),
              child: GestureDetector(
                child: CircleAvatar(
                  radius: 2.5.h,
                  backgroundImage: _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                  child:_imageBytes == null
                      ? Icon(Icons.person, size: 10.h, color: Colors.grey)
                      : null,
                  backgroundColor: Colors.indigo,
                ),
                onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: EditProfile()));
                },
              )
          ),
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: GestureDetector(
              child: CircleAvatar(
                radius: 2.5.h,
                child: Icon(Icons.notifications_none_outlined,color: primary,),
                backgroundColor: secondary,
              ),
              onTap: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: NotificationScreen()));
              },
            ),
          )
        ],
      ),backgroundColor: primary,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color:Color(0xFF6A7E64),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(5.h),topRight: Radius.circular(5.h))
        ),
        child:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h,),
                TermsAndPolicyHeadings(title: 'Murabaha', data: Icons.square_sharp,color: Colors.indigo,angle: 0.785398,),
                Center(child: Text('(Cost-Plus Sale Financing)',style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: secondary,
                    fontWeight: FontWeight.w600
                ),),),
                SizedBox(height: 2.h,),
                SubHeadings(title: 'Overview:'),
                LongText(text: 'A transaction where the lender buys an asset and sells it to the borrower at a profit. The profit margin is disclosed upfront and repayment is structured over time.'),
                SizedBox(height: 3.h,),
                SubHeadings(title: "Lender's Perspective:"),
                Subtext(text: 'Return: Fixed, disclosed profit margin. No addition\nand subtraction of profit'),
                Subtext(text: 'Low, since ownership of goods is transferred\nupon purchase.'),
                Subtext(text: 'Ideal For: Lenders looking for predictable,\nShariah-compliant profit returns.'),
                Subtext(text: 'Repayment Terms: Installments or lump-sum,\nover fixed periods.'),
                Subtext(text: 'Shariah Compliance: No hidden costs, full\ntransparency of cost and margin.'),
                SizedBox(height: 2.h,),
                SubHeadings(title: 'Suggested Add-On Feature For Lenders:'),
                Subtext(text: "Select assets from marketplace directly. No middle\nperson between dealing."),
                Subtext(text: 'Option to set custom profit margins within\nethical limits.'),
                SizedBox(height: 2.h,),
                Center(child: GestureDetector(child: UserButton(color: Color(0xFFD3D3D3), text: 'Application Portal ', text_color: primary, height: 7, width: 32,flag: true,border: 5,),onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: ApplicationScreen2()));
                },))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
