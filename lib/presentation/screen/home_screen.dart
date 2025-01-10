// Refactored home_screen.dart
import 'dart:developer';

import 'package:firebase_cloud/presentation/screen/opened_screen.dart';
import 'package:firebase_cloud/utils/notification_util.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationUtil.showNotification(
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OpenedScreen(remoteMessage: message),
        ),
      );
    }); // if app is in background and recieved notification, it will trigger when we press notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      log(" onMessageOpenedApp Title:- ${remoteMessage.notification?.title}");
      log("onMessageOpenedApp Body:- ${remoteMessage.notification?.body}");

      // navigate to opend screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OpenedScreen(remoteMessage: remoteMessage)));
      });
    });

    // if app is in terminated and recieved notification, it will trigger when we press notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        log(" getInitialMessage Title:- ${remoteMessage.notification?.title}");
        log("getInitialMessage Body:- ${remoteMessage.notification?.body}");

        // navigate to opened screen
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  OpenedScreen(remoteMessage: remoteMessage)));
        });
      } else {
        log("getInitialMessage Remote message is null");
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: const Center(
        child: Text("Welcome to Home Screen"),
      ),
    );
  }
}
