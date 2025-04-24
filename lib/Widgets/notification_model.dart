import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  AppNotification({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });

  factory AppNotification.fromMap(Map<String, dynamic> data) {
    return AppNotification(
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isRead: data['isRead'] ?? false,
    );
  }
}
