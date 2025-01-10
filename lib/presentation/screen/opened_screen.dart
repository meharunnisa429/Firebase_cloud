// Refactored opened_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class OpenedScreen extends StatelessWidget {
  final RemoteMessage remoteMessage;
  const OpenedScreen({super.key, required this.remoteMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              remoteMessage.notification?.title ?? "No Title",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(remoteMessage.notification?.body ?? "No Body"),
          ],
        ),
      ),
    );
  }
}
