import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:karim_pay/Screens/bottom_nav_bar.dart';
import 'package:karim_pay/Screens/home_screen.dart';
import 'package:karim_pay/Widgets/custom_check_box.dart';
import 'package:karim_pay/Widgets/filterbutton.dart';
import 'package:karim_pay/Widgets/long_text.dart';
import 'package:karim_pay/Widgets/sub_headings.dart';
import 'package:karim_pay/Widgets/sub_text.dart';
import 'package:karim_pay/Widgets/terms_and_policy_headings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'notification_screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool _agreeTerms = false;
  bool _acceptPrivacy = false;
  void _navigateIfBothChecked() async {
    if (_agreeTerms && _acceptPrivacy) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'policyverification': true});
      }
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: BottomNavBar(
            flag: true,
          ),
        ),
      );
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
            Text(
              'Hi, Welcome Back',
              style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: secondary),
            ),
            Text('Good Morning',
                style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: secondary)),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: CircleAvatar(
              radius: 2.5.h,
              child: GestureDetector(
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: primary,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: NotificationScreen()));
                },
              ),
              backgroundColor: secondary,
            ),
          )
        ],
      ),
      backgroundColor: primary,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFF6A7E64),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.h), topRight: Radius.circular(5.h))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                TermsAndPolicyHeadings(
                  title: 'Privacy Policy',
                  data: Icons.privacy_tip_outlined,
                ),
                SizedBox(
                  height: 1.h,
                ),
                LongText(
                    text:
                        'We are committed to protecting your personal and financial data in accordance with Islamic ethical standards and global data privacy norms.'),
                SubHeadings(title: '1. Data Collection'),
                LongText(text: 'We may collect the following data:'),
                Subtext(
                  text:
                      'Personal identification information like Name, CNIC\nandDOB',
                ),
                Subtext(
                    text:
                        'Contact details and Financial documents\ne.g., salary slips, bank statements'),
                Subtext(
                    text:
                        'Device and usage information\n(for app performance and analytics)'),
                SizedBox(
                  height: 1.h,
                ),
                SubHeadings(title: '2. Data Usage'),
                Subtext(
                  text:
                      'Data is used solely to assess eligibility, process\nloan applications, and provide support.',
                ),
                Subtext(
                    text:
                        'We do not sell or trade your data with third parties\napp.'),
                Subtext(
                    text:
                        'AI algorithms may use your anonymized data to\nimprove services and risk profiling.'),
                SizedBox(
                  height: 1.h,
                ),
                SubHeadings(title: '3. Data Storage'),
                Subtext(
                    text:
                        'All data is stored securely using our encrypted\ndatabases.'),
                Subtext(
                    text:
                        'Only authorized personnel can access sensitive\ndata, under confidentiality agreements.'),
                SizedBox(
                  height: 1.h,
                ),
                SubHeadings(title: '4. User Rights'),
                Subtext(
                    text:
                        'You may request to view, edit, or delete your data\nat any time.'),
                Subtext(
                    text:
                        'You have the right to withdraw consent and\nclose your account.'),
                SizedBox(
                  height: 1.h,
                ),
                SubHeadings(title: '5. Shariah Ethics in Data Handling'),
                Subtext(
                    text:
                        "We ensure Amanah (trust) in handling your\npersonal data."),
                Subtext(
                    text:
                        'Transparency and honesty (Sidq) are core to\nour data practices.'),
                SizedBox(
                  height: 1.h,
                ),
                SubHeadings(title: '6. Cookies & Tracking'),
                LongText(
                    text:
                        'We use limited cookies to improve app performance. No personal tracking is performed without consent.'),
                SizedBox(
                  height: 1.h,
                ),
                SubHeadings(title: '7. Policy Updates'),
                LongText(
                    text:
                        'We may update this policy to comply with laws or improve protection. Users will be notified via app alerts.'),
                SizedBox(
                  height: 2.h,
                ),
                CustomCheckboxTile(
                  value: _agreeTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeTerms = value!;
                      _navigateIfBothChecked();
                    });
                  },
                  title: 'I Have Read And Agree To The Terms & Conditions.',
                ),
                CustomCheckboxTile(
                  value: _acceptPrivacy,
                  onChanged: (value) {
                    setState(() {
                      _acceptPrivacy = value!;
                      _navigateIfBothChecked();
                    });
                  },
                  title: 'I Understand And Accept The Privacy Policy.',
                ),
                SizedBox(
                  height: 3.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
