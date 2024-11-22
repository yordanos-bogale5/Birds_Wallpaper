import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../notification_service/notification_service.dart';
import '../../authorization/views/selection_screen.dart';
import '../../home/data/services/socket_service.dart';

Future<void> logOut(BuildContext context, WidgetRef ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", '');
  // ref.read(socketServiceProvider).disconnectSocket();
  NotificationService().checkAndSendNotifications();
  Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => SelectionScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
      // MaterialPageRoute(builder: (context) =>  SelectionScreen()),
      (route) => false);
}
