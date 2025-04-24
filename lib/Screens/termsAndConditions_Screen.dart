import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karim_pay/Constants/constants.dart';
import 'package:karim_pay/Screens/privacy_policy_screen.dart';
import 'package:karim_pay/Widgets/filterbutton.dart';
import 'package:karim_pay/Widgets/long_text.dart';
import 'package:karim_pay/Widgets/sub_headings.dart';
import 'package:karim_pay/Widgets/sub_text.dart';
import 'package:karim_pay/Widgets/terms_and_policy_headings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'notification_screen.dart';
class TermsandconditionsScreen extends StatefulWidget {
  const TermsandconditionsScreen({super.key});

  @override
  State<TermsandconditionsScreen> createState() => _TermsandconditionsScreenState();
}

class _TermsandconditionsScreenState extends State<TermsandconditionsScreen> {
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
            child: CircleAvatar(
              radius: 2.5.h,
              child: GestureDetector(child: Icon(Icons.notifications_none_outlined,color: primary,),onTap: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: NotificationScreen()));
              },),
              backgroundColor: secondary,
            ),
          )
        ],
      ),
      backgroundColor: primary,
      body: Container(
        width: double.infinity,
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
                TermsAndPolicyHeadings(title: 'Terms & Conditions',data: Icons.contact_page_outlined,),
                SizedBox(height: 1.h,),
                LongText(text: 'By accessing our application, you agree to comply and be bound by the following terms and conditions. If you do not agree with these terms, please do not use the app.'),
                SubHeadings(title: '1. Shariah Complinace'),
                Subtext(text: 'All financial activities conducted through this app\nare in full compliance with Islamic Finance principles.',),
                Subtext(text: 'No interest (Riba) is charged or accepted on any\nloan products.'),
                Subtext(text: 'Loans must follow profit-loss sharing, Murabaha,\nor Qard Hasan models where applicable.'),
                SizedBox(height: 1.h,),
                SubHeadings(title: '2. Loan Application'),
                Subtext(text: 'Users must submit accurate and complete personal\nand financial information',),
                Subtext(text: 'The application may require supporting documents\n(CNIC, salary slips, guarantor info'),
                Subtext(text: 'All loans are subject to approval based on AI-assisted\nrisk assessment and Shariah governance criteria.'),
                SizedBox(height: 1.h,),
                SubHeadings(title: '3. Loan Distribution & Repayment'),
                Subtext(text: 'Loan terms (amount, duration, profit margin) are\ntransparently displayed before final submission.'),
                Subtext(text: 'Repayment is expected within the agreed timeframe.\nDelayed repayments may affect future loan eligibility\nbut will not incur penalty fees or interest.'),
                Subtext(text: 'Users can repay early without any additional cost.\nThis will help them win On-Time Payer badge'),
                SizedBox(height: 1.h,),
                SubHeadings(title: '4. User Obligations'),
                Subtext(text: 'Users agree to use the loan funds strictly for\nHalal (permissible) purposes.'),
                Subtext(text: 'Misuse of funds or submission of fraudulent\ndocuments may result in legal action.'),
                Subtext(text: 'Users must maintain the confidentiality of their\naccount and personal credentials.'),
                SizedBox(height: 1.h,),
                SubHeadings(title: '5. Limitations of Liability'),
                Subtext(text: "The app provides recommendations and loan\napprovals based on AI and user-submitted data."),
                Subtext(text: 'The platform reserves the right to suspend any\naccount found in violation of these terms.'),
                SizedBox(height: 1.h,),
                SubHeadings(title: '6. Modification of Terms'),
                LongText(text: 'We reserve the right to update these Terms & Conditions at any time. Continued use of the app after changes implies acceptance.'),
                SizedBox(height: 1.h,),
                SubHeadings(title: '7. Governing Law'),
                LongText(text: 'These terms are governed by the Shariah Law principles and relevant local regulations of your region.'),
                SizedBox( height: 2.h,),
                Center(child: FilterSearchButton(onPressed: (){
                  Navigator.push(context, PageTransition(type: PageTransitionType.fade,child: PrivacyPolicyScreen()));
                }, height: 6.h, width: 28.w, title: 'Next', fontsize:14.sp)),
                SizedBox(height: 3.h,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
