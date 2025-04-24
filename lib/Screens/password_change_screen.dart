import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPaint(
              size:  Size(20.h, 20.h), // Adjust size as needed
              painter: CirclePainter(),
            ),
            SizedBox(height: 3.h,),
            Text('Password Has been\nChanged successfully',style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color:secondary
            ),
            textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = secondary // Light green stroke color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Paint smallCirclePaint = Paint()
      ..color = secondary // Small circle color
      ..style = PaintingStyle.fill;

    // Draw the outer circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    // Draw the small inner circle (positioned towards top-left)
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.3), size.width * 0.1, smallCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
