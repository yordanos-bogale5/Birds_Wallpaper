import 'dart:developer';

import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/favourities/provider/favourites_provider.dart';
import 'package:chatremedy/src/features/favourities/provider/get_favourites.dart';
import 'package:chatremedy/src/features/home/views/bottom_bar_screen.dart';
import 'package:chatremedy/src/model/all_data/all_data.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_video/stream_video.dart' as vid;

import '../../../notification_service/notification_service.dart';
import '../../../utils/base_url.dart';
import '../../home/data/functions/get_all.dart';
import '../../home/data/functions/get_all_users.dart';
import '../../home/data/provider/all_data_provider.dart';
import '../../home/data/provider/list_counsellor_provider.dart';
import '../../home/data/services/socket_service.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final NotificationService notificationService = NotificationService();


  initSocket() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    ref.read(socketServiceProvider).initializeSocket('$token', ref);
  }

  @override
  void initState() {
    super.initState();

    initSocket();
    notificationService.init(ref);
    streamInit();
    Future.delayed(const Duration(seconds: 3), () {
      fetchAllData().then((val) {
        ref
            .read(allDataProvider.notifier)
            .change(val ?? AllData(religions: [], languages: [], genders: []));
      });
      getCounsellors();
    });
  }

  streamInit() async {
    final user = ref.read(userProvider);
    await client.connectUser(
      User(
          id: '${user.user!.id}',
          name: '${user.user?.firstname} ${user.user?.lastname}'),
      user.user!.streamUserToken!,
    );

    await setStreamVideoClient(user.user!.streamUserToken!, '${user.user!.id}',
        '${user.user?.firstname} ${user.user?.lastname}');
  }

  getCounsellors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    getFavourites(token ?? "").then((value) {
      ref.read(favouritesProvider.notifier).change(value);
    });
    getAllUsers(token ?? "", "Counsellor").then((value) {
      ref.read(listCounsellorProvider.notifier).change(value);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const BottomBarScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
        // MaterialPageRoute(builder: (context) => const BottomBarScreen())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Image(image: AssetImage(AppImages.logo)),
            ),
            Text(
              "Hi ${user.user!.username}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "We're here to listen",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
