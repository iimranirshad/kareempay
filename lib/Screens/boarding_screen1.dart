import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
class BoardingScreen1 extends StatefulWidget {
  const BoardingScreen1({super.key});

  @override
  State<BoardingScreen1> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen1> {
  bool flag = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Container(
        color: primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15.h,),
            Text(
              flag == true?
              'Trust. Integrity. Growth—The Halal Way with KarimPay!':'Need a Halal Loan? Take Your Next Step with Confidence!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 24.sp,
                  color: secondary,
                  fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 5.h,),
            Container(
              width: double.infinity,
              height: 62.5.h,
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.h),
                  topRight: Radius.circular(6.h),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  CircleAvatar(
                    radius: 12.h,
                    backgroundColor: secondary,
                    backgroundImage: AssetImage(flag==true?'assets/images/boarding1.png':'assets/images/boarding1.png'),
                  ),
                  SizedBox(height: 3.h,),
                  Center(child: GestureDetector(
                    child: Text('Next',style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),),
                    onTap: (){
                      setState(() {
                        flag = true;
                      });
                    },
                  ),),
                  SizedBox(height: 4.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 1.5.h,
                        height: 1.5.h,
                        decoration: BoxDecoration(
                          color: flag==true?Colors.grey:Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 3.w,),
                      Container(
                        width: 1.5.h,
                        height: 1.5.h,
                        decoration: BoxDecoration(
                          color: flag==true?Colors.white:Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
