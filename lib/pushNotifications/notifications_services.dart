import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/notification_screen.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  List<RemoteMessage> notifications = [];

  NotificationService() {
    loadNotifications();
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint("User granted provisional permission");
    } else {
      debugPrint("User granted no permission");
    }
  }

  void initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializeSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializeSetting,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(message, context);
        });
  }

  Future<void> showNotification(RemoteMessage message) async {
    notifications.add(message);
    saveNotifications();

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      "High Importance Notification",
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(), channel.name.toString(),
      channelDescription: 'Your channel description',
      importance: Importance.high,
      ticker: 'ticker',
      priority: Priority.high,
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title.toString(),
        message.notification?.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    debugPrint("Token: $token");
    return token!;
  }

  Future<void> initialBackgroundMessage(BuildContext context) async {
    RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      handleMessage(remoteMessage, context);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(event, context);
    });
  }

  void firebaseInitMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        debugPrint(message.notification?.title.toString());
        debugPrint(message.notification?.body.toString());
        debugPrint(message.data.toString());
      }

      initLocalNotifications(context, message);
      showNotification(message);
    });
  }

  void handleMessage(RemoteMessage message, BuildContext context) {
    if (message.data['type'] == 'drink') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationScreen(
            id: message.data['id'],
          ),
        ),
      );
    }
  }

  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void saveNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notificationsJson = notifications.map((e) => jsonEncode(e.toMap())).toList();
    await prefs.setStringList('notifications', notificationsJson);
  }

  void loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notificationsJson = prefs.getStringList('notifications');
    if (notificationsJson != null) {
      notifications = notificationsJson.map((e) => RemoteMessage.fromMap(jsonDecode(e))).toList();
    }
  }
}
