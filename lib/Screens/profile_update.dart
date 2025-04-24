import 'dart:convert';
import 'dart:typed_data';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karim_pay/Screens/notification_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
import '../Widgets/application_fields.dart';
import '../Widgets/user_button.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({super.key});

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final TextEditingController phoneNumber = TextEditingController();
  Uint8List? _profileImageBytes;
  String? base64Image;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _profileImageBytes = bytes;
        base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _loadProfileData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      phoneNumber.text = data['phoneNumber'] ?? '';
      if (data['profileImage'] != null) {
        setState(() {
          _profileImageBytes = base64Decode(data['profileImage']);
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      // Update profile info
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'phoneNumber': phoneNumber.text,
        if (base64Image != null) 'profileImage': base64Image,
      });

      // Add a notification document
      await FirebaseFirestore.instance.collection('notifications').add({
        'uid': uid,
        'title': 'Profile Updated',
        'message': 'Your profile was successfully updated.',
        'timestamp': FieldValue.serverTimestamp(),
        'isRead': false, // Optional: used to mark as read later
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Updated!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
              fontSize: 18.sp, fontWeight: FontWeight.w600, color: secondary),
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: secondary),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: GestureDetector(
              child: CircleAvatar(
                radius: 2.5.h,
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: primary,
                ),
                backgroundColor: secondary,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: NotificationScreen()));
              },
            ),
          )
        ],
      ),
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      height: 79.5.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6A7E64),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.h),
                          topRight: Radius.circular(5.h),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 15.h,
                  top: 2.h,
                  child: Stack(
                    children: [
                      CircularProfileAvatar(
                        '',
                        child: _profileImageBytes != null
                            ? ClipOval(
                                child: Image.memory(
                                  _profileImageBytes!,
                                  fit: BoxFit.cover,
                                  width: 16.h,
                                  height: 16.h,
                                ),
                              )
                            : Icon(Icons.person, size: 50),
                        backgroundColor: Colors.lightBlue,
                        borderColor: Colors.white,
                        borderWidth: 2,
                        radius: 8.h,
                        onTap: _pickImage,
                      ),
                      Positioned(
                        bottom: -3,
                        right: 2.h,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 5.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 3.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 12.h,
                  top: 18.h,
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      Text(
                        'Aitsam ul Hassan',
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: secondary),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'ID: 25030024',
                        style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: secondary),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 30.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Settings',
                          style: GoogleFonts.poppins(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: secondary),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Phone Number         ',
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: secondary),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 40.h,
                  child: Container(
                    width: double.infinity,
                    child: ApplicationFields(
                      label: 'Phone Number',
                      inputType: TextInputType.phone,
                      controller: phoneNumber,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 10.h,
                  child: GestureDetector(
                    onTap: _updateProfile,
                    child: UserButton(
                      color: primary,
                      text: 'Update Profile',
                      text_color: Colors.white,
                      height: 10,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
