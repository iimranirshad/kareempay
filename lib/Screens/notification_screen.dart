import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../Constants/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final uid = FirebaseAuth.instance.currentUser?.uid; // Replace with dynamic user id if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
              fontSize: 18.sp, fontWeight: FontWeight.w600, color: secondary),
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: secondary),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('uid', isEqualTo: uid)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data?.docs ?? [];

          // Optional debug print to check what's coming from Firestore
          for (var doc in notifications) {
            debugPrint('Document ${doc.id} data: ${doc.data()}');
          }

          if (notifications.isEmpty) {
            return Center(
              child: Text(
                'No notifications found.',
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(2.h),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final doc = notifications[index];
              final data = doc.data();

              // Defensive type check
              if (data is! Map<String, dynamic>) {
                debugPrint('⚠️ Skipping invalid document ${doc.id}');
                return const SizedBox.shrink();
              }

              try {
                final title = data['title'] ?? 'No Title';
                final message = data['message'] ?? 'No Message';
                final timestamp = (data['timestamp'] as Timestamp).toDate();
                final formattedTime =
                DateFormat('dd MMM yyyy, hh:mm a').format(timestamp);

                return Card(
                  color: primary,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.h),
                  ),
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                              fontSize: 13.sp, fontWeight: FontWeight.bold,color: secondary),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          message,
                          style: GoogleFonts.poppins(fontSize: 11.sp,color: secondary),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          formattedTime,
                          style: GoogleFonts.poppins(
                              fontSize: 10.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              } catch (e) {
                debugPrint('❌ Error parsing notification ${doc.id}: $e');
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
