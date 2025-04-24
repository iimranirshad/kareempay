import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Screens/ijara_screen.dart';
import 'package:karim_pay/Screens/mudarabah_screen.dart';
import 'package:karim_pay/Screens/murabaha_screen.dart';
import 'package:karim_pay/Screens/notification_screen.dart';
import 'package:karim_pay/Screens/qard_hasan_screen.dart';
import 'package:karim_pay/Screens/termsAndConditions_Screen.dart';
import 'package:karim_pay/Widgets/filter_search.dart';
import 'package:karim_pay/Widgets/filterbutton.dart';
import 'package:karim_pay/Widgets/loan_buttons.dart';
import 'package:karim_pay/Widgets/terms&conditions.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../Constants/constants.dart';
import '../Widgets/home_containers.dart';
import '../Widgets/home_option_container.dart';
import '../Widgets/profile_avatar.dart';

class HomeScreen extends StatefulWidget {
  final bool? flag;
  const HomeScreen({super.key, this.flag});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController repayDateController = TextEditingController();
  final TextEditingController creditScoreController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController riskLevelController = TextEditingController();
  Uint8List? _imageBytes;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  final now = DateTime.now();
  @override
  void initState() {
    super.initState();
    _loadUserProfileImage();
    fetchUserData();
  }

  Future<void> _loadUserProfileImage() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists && doc.data()!['profileImage'] != null) {
      setState(() {
        _imageBytes = base64Decode(doc.data()!['profileImage']);
      });
    }
  }

  Future<void> fetchUserData() async {
    try {
      final uid =
          FirebaseAuth.instance.currentUser?.uid; // Replace with dynamic UID
      final doc = await FirebaseFirestore.instance
          .collection('applications')
          .doc(uid)
          .get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
          isLoading = false;
          creditScoreController.text = userData!['creditScore'].toString();
          loanAmountController.text = userData!['amount'].toString();

          // Calculate risk level
          double risk = calculateRisk(
            int.parse(userData!['creditScore'].toString()),
            double.parse(userData!['amount'].toString()),
          );
          riskLevelController.text = '${risk.toStringAsFixed(1)}%';

          // Calculate repayment date (30 days from now)
          DateTime repayDate = DateTime.now().add(Duration(days: 30));
          repayDateController.text =
              "${repayDate.day}/${repayDate.month}/${repayDate.year}";
        });
        await Future.delayed(Duration(seconds: 1));
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() => isLoading = false);
    }
  }

  double calculateRisk(int creditScore, double loanAmount) {
    double riskFromCredit =
        (800 - creditScore) / 8; // Assuming 800 is max score
    double riskFromLoan = loanAmount / 10000; // 1% per $10,000
    double totalRisk = riskFromCredit + riskFromLoan;
    return totalRisk.clamp(0.0, 100.0); // Keep within 0-100%
  }

  @override
  void dispose() {
    repayDateController.dispose();
    creditScoreController;
    loanAmountController;
    riskLevelController;
    super.dispose();
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
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: secondary),
            ),
            Text('Good Morning',
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: secondary)),
          ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Row(
                children: [
                  ProfileAvatar(
                    imageBytes: _imageBytes,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 13.h,
                    width: 2,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  if (userData != null) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total Borrowed Fund',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: secondary),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          '${userData!['amount']}',
                          style: GoogleFonts.poppins(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: secondary),
                        ),
                        Row(
                          children: [
                            Text(
                              'Loan Eligibility:',
                              style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: secondary,
                                  fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              ' \$0',
                              style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: secondary),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Loan Limit Remaining:',
                              style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: secondary,
                                  fontStyle: FontStyle.italic),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              '${userData!['amount']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: secondary),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.wine_bar,
                              color: Colors.green,
                              size: 5.h,
                            ),
                            Text(
                              'On-Time Payer',
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: secondary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Account No.',
                          style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: secondary),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          '${now.millisecondsSinceEpoch}',
                          style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3299FF)),
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 2.h),
            //   child: Text(
            //     'Filter Search',
            //     style: GoogleFonts.poppins(
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w400,
            //         color: secondary,
            //         fontStyle: FontStyle.italic),
            //   ),
            // ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          FilterTextField(
                            hintText: 'Credit Score',
                            controller: creditScoreController,
                            readOnly: true,
                          ),
                          SizedBox(
                            width: 0.5.h,
                          ),
                          FilterTextField(
                            hintText: 'Loan Amount\$',
                            controller: loanAmountController,
                            readOnly: true,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          FilterTextField(
                            hintText: 'Risk Level%',
                            controller: riskLevelController,
                            readOnly: true,
                          ),
                          SizedBox(
                            width: 0.5.h,
                          ),
                          FilterTextField(
                            hintText: 'Repay Date',
                            readOnly: true,
                            showCalendar: true,
                            controller: repayDateController,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  FilterSearchButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Risk Level is High')),
                        );
                      },
                      height: 6.h,
                      width: 28.w,
                      fontsize: 14.sp,
                      title: 'Repay')
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            SingleChildScrollView(
              child: Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF6A7E64),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.h),
                        topRight: Radius.circular(5.h))),
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 2.h),
                    child: Column(
                      children: [
                        // SizedBox(height:1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.flag == true
                                ? Text(
                                    'Terms and Conditions',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: secondary,
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              width: 2.w,
                            ),
                            FilterSearchButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Read Terms and Condition First')),
                                  );
                                },
                                height: 4.h,
                                width: 25.w,
                                fontsize: 10.sp,
                                title: 'Apply For Loan'),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        widget.flag == true
                            ? Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: const Color(
                                      0xFF4C4C4C), // Dark gray inner box
                                  borderRadius: BorderRadius.circular(3.h),
                                ),
                                child: Column(
                                  children: [
                                    TermsAndConditions(
                                        term:
                                            'This loan is fully Shariah-compliant.'),
                                    TermsAndConditions(
                                        term:
                                            'No interest (Riba) is charged at any \nstage.'),
                                    TermsAndConditions(
                                        term:
                                            'Repayment must be made within the \nagreed time frame.'),
                                    TermsAndConditions(
                                        term:
                                            'Profit margins (if any) are fixed and \ndisclosed upfront.'),
                                    TermsAndConditions(
                                        term:
                                            'Funds must be used for halal purposes \nonly.'),
                                    TermsAndConditions(
                                        term:
                                            'Late payments will not incur penalties \nbut may affect future eligibility.'),
                                    TermsAndConditions(
                                        term:
                                            'Early repayment is allowed and \nencouraged.'),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Handle navigation to full terms page
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.arrow_forward,
                                              color: Colors.white),
                                          GestureDetector(
                                            child: Text(
                                              "[Read Full Terms & Conditions]",
                                              style: GoogleFonts.poppins(
                                                color: Colors.blueAccent,
                                                fontSize: 14.sp,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          TermsandconditionsScreen()));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: secondary, // Dark gray inner box
                                  borderRadius: BorderRadius.circular(3.h),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        LoanButtons(
                                          title: 'Qard Hasan',
                                          subtitle: 'Interest-Free Loan',
                                          detail: 'Pure goodwill lending',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: QardHasanScreen()));
                                          },
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        LoanButtons(
                                          title: 'Ijara',
                                          subtitle: 'Lease-Based Loan',
                                          detail: 'Asset leasing solution',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: IjaraScreen()));
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        LoanButtons(
                                          title: 'Murabaha',
                                          subtitle: 'Cost-Plus Loan',
                                          detail: 'Profit-disclosed financing',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: MurabahaScreen()));
                                          },
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        LoanButtons(
                                          title: 'Mudarabah',
                                          subtitle: 'Investment Loan',
                                          detail: 'Profit-sharing venture',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: MudarabahScreen()));
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
