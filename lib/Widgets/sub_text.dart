import 'package:flutter/material.dart';
import 'package:karim_pay/Widgets/long_text.dart';
import 'package:sizer/sizer.dart';
class Subtext extends StatelessWidget {
  final String text;
  const Subtext({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.h),
      child: Row(
        children: [
          Column(
            children: [
              Icon(Icons.circle,color: Colors.white,size: 0.7.h,),
              SizedBox(height: 2.h,)
            ],
          ),
          SizedBox(width: 1.w,),
          LongText(text: text)
        ],
      ),
    );
  }
}
