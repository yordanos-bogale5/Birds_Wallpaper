import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:chatremedy/src/features/authorization/provider/register_device_for_notification.dart';
import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init(WidgetRef ref) async {
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true);
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _setUpNotifications(ref);
  }

  ///Firebase Push Notifications

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<Null> _setUpNotifications(WidgetRef ref) async {
    _firebaseMessaging.requestPermission();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('onMessage: $message');
      if (message.notification != null) {
        showNotification(message.notification?.title ?? "",
            message.notification?.body ?? "");
      }
      return;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
    });

    final user = ref.watch(userProvider);

    _firebaseMessaging.getToken().then((token) {

      if (user.user != null) {
        final String? jwtToken = prefs.getString('token');
        registerDevice(user.user?.email ?? "", token!, jwtToken ?? "");
      }
    });
  }

  Future<void> checkAndSendNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null || token == '') {
      await _scheduleNotifications();
    }
  }

  Future<void> _scheduleNotifications() async {
    for (int i = -24; i < 100; i = i + 2) {
      await _scheduleNotification(
          i < 0
              ? DateTime.now().subtract(Duration(hours: i))
              : DateTime.now().add(Duration(hours: i)),
          i);
    }
  }

  Future<void> cancelNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> _scheduleNotification(
      DateTime scheduledDate, int notificationId) async {
    final String localTimezone = tz.local.name;

    final location = tz.getLocation(localTimezone); // Set your timezone here

    final scheduledTime = tz.TZDateTime(
        location,
        scheduledDate.year,
        scheduledDate.month,
        scheduledDate.day,
        scheduledDate.hour,
        scheduledDate.minute);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            channelDescription: 'your_channel_description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(threadIdentifier: 'thread_id');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        'Register Today',
        "Have you created an account yet? - IT'S FREE!",
        scheduledTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> showNotification(String title, String description) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('150', 'Chatremedy',
            channelDescription: 'Chatremedy User',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(threadIdentifier: '150');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, title, description, platformChannelSpecifics);
  }
}
