
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Screens/profile_update.dart';
import 'package:karim_pay/Widgets/profile_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../Constants/constants.dart';
import '../Widgets/profile_avatar.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Uint8List? _imageBytes;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  void initState() {
    super.initState();
    _loadUserProfileImage();
  }
  Future<void> _loadUserProfileImage() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists && doc.data()!['profileImage'] != null) {
      setState(() {
        _imageBytes = base64Decode(doc.data()!['profileImage']);
      });
    }
  }
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login screen or update UI
    } catch (e) {
      print("Error signing out: $e");
      // Handle error (e.g., show a snackbar)
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text('Profile',style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: secondary
        ),),
        leading: GestureDetector(child: Icon(Icons.arrow_back,color: secondary,),onTap: (){
          Navigator.pop(context);
        },),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: CircleAvatar(
              radius: 2.5.h,
              child: Icon(Icons.notifications_none_outlined,color: primary,),
              backgroundColor: secondary,
            ),
          )
        ],
      ),
      backgroundColor: primary,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 10.h,),
              Container(
                width: double.infinity,
                height: 79.5.h,
                decoration: BoxDecoration(
                    color:Color(0xFF6A7E64),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5.h),topRight: Radius.circular(5.h))
                ),
              ),
            ],
          ),
          Positioned(left: 15.h,top: 2.h,
            child: ProfileAvatar(imageBytes: _imageBytes,)),
          Positioned(left: 12.h,top: 18.h,child: Column(
            children: [
              SizedBox(height: 2.h,),
              Text('Aitsam ul Hassan',style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: secondary
              ),),
              SizedBox(height: 1.h,),
              Text('ID: 25030024',style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: secondary
              ),),
            ],
          ),),
          Positioned(left: 3.h,top:30.h,child: Column(
            children: [
              GestureDetector(child: ProfileWidget(icon: Icons.person_2_outlined, title: 'Edit Profile'),onTap: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: ProfileUpdate()));
              },),
              SizedBox(height: 3.h,),
              GestureDetector(child: ProfileWidget(icon: Icons.logout, title: 'Logout      '),onTap: _logout,),
            ],
          ))
        ],
      ),
    );
  }
}
