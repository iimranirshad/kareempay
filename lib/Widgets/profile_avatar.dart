import 'dart:typed_data';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';
class ProfileAvatar extends StatelessWidget {
  double radius;
  final Uint8List? imageBytes;
  ProfileAvatar({super.key,this.radius = 8, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      '',
      child: imageBytes != null
          ? ClipOval(
        child: Image.memory(
          imageBytes!,
          fit: BoxFit.cover,
          width: 16.h,
          height: 16.h,
        ),
      )
          : Icon(Icons.person, size: 50),
      backgroundColor: Colors.blueAccent,
      borderWidth: 1,
      borderColor: secondary,
      radius: radius.h,
      cacheImage: true,
      errorWidget: (context, url, error) {
        return Icon(
          Icons.face,
          size: 20.h,
        );
      },
      onTap: () {},
      animateFromOldImageOnUrlChange: true,
      placeHolder: (context, url) {
        return Container(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
