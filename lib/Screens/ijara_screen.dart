import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:karim_pay/Screens/application_screen3.dart';
import 'package:karim_pay/Screens/notification_screen.dart';
import 'package:karim_pay/Screens/profile_update.dart';
import 'package:karim_pay/Widgets/long_text.dart';
import 'package:karim_pay/Widgets/sub_headings.dart';
import 'package:karim_pay/Widgets/sub_text.dart';
import 'package:karim_pay/Widgets/terms_and_policy_headings.dart';
import 'package:karim_pay/Widgets/user_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'edit_profile.dart';
class IjaraScreen extends StatefulWidget {
  const IjaraScreen({super.key,});

  @override
  State<IjaraScreen> createState() => _IjaraScreenState();
}

class _IjaraScreenState extends State<IjaraScreen> {
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
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: secondary
            ),),
            Text('Good Morning',style: GoogleFonts.poppins(
                fontSize: 12.sp,
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
                TermsAndPolicyHeadings(title: 'Ijara', data: Icons.square_sharp,color: Colors.indigo,angle: 0.785398,),
                Center(child: Text('(Lease-Based Financing)',style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: secondary,
                    fontWeight: FontWeight.w600
                ),),),
                SizedBox(height: 2.h,),
                SubHeadings(title: 'Overview:'),
                LongText(text: 'An Islamic leasing arrangement where the lender (lessor) buys and leases an asset to the borrower (lessee) for a fixed rental period and amount.'),
                SizedBox(height: 3.h,),
                SubHeadings(title: "Lender's Perspective:"),
                Subtext(text: 'Return: Periodic rental payments; asset ownership\nretained by lender.'),
                Subtext(text: 'Moderate; depends on asset depreciation and\nlessee conduct.'),
                Subtext(text: 'Ideal For: Lenders with higher capital, willing to invest\nin long-term leases.'),
                Subtext(text: 'Repayment Terms:Monthly/quarterly rentals;\nterms fixed at contract initiation.'),
                Subtext(text: 'Shariah Compliance: No interest; must clearly outline\nrights, responsibilities, and maintenance roles.'),
                SizedBox(height: 2.h,),
                SubHeadings(title: 'Suggested Add-On Feature For Lenders:'),
                Subtext(text: "View asset tracking and maintenance of the history\nfor their lease."),
                Subtext(text: 'Choose lease tenure, rental value, and add\ninsurance protection.'),
                SizedBox(height: 2.h,),
                Center(child: GestureDetector(child: UserButton(color: Color(0xFFD3D3D3), text: 'Application Portal ', text_color: primary, height: 7, width: 32,flag: true,border: 5,textsize: 16,),onTap: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: ApplicationScreen3()));
                },))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
