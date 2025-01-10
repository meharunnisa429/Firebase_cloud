// New fcm_service.dart
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static Future<void> initialize() async {
    // Request notification permissions
    final NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');

    // Get FCM token
    final String? token = await FirebaseMessaging.instance.getToken();
    log('FCM Token: $token');

    // Subscribe to a topic
    await FirebaseMessaging.instance.subscribeToTopic('meharunnisa');

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    log('Background message: ${message.notification?.title} - ${message.notification?.body}');
  }
}
