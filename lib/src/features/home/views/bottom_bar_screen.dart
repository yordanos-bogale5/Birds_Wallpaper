import 'package:chatremedy/src/features/chat/provider/unread_indicator.dart';
import 'package:chatremedy/src/features/chat/views/inbox_screen.dart';
import 'package:chatremedy/src/features/home/views/home_screen.dart';
import 'package:chatremedy/src/features/profile/views/profile_screen.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int currentIndex = 0;

  final screens = [
    const HomeScreen(),
    const InboxScreen(),
    const ProfileScreen(),
  ];

  getUnreadCount() {}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppSvg.homeOutlined,
                height: 24,
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                AppSvg.homeFilled,
                height: 24,
                width: 24,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: SizedBox(
                width: 40,
                height: 25,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      AppSvg.messageOutlined,
                      height: 24,
                      width: 24,
                    ),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: UnreadIndicatorInbox())
                  ],
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppSvg.userOutlined,
                height: 24,
                width: 24,
              ),
              activeIcon: SvgPicture.asset(
                AppSvg.userFiled,
                height: 20,
                width: 20,
              ),
              label: ""),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
