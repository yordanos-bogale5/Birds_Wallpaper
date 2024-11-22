
import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:chatremedy/src/features/authorization/views/selection_screen.dart';
import 'package:chatremedy/src/features/splash_screen/provider/get_logged_in_user.dart';
import 'package:chatremedy/src/features/splash_screen/view/welcome_screen.dart';
import 'package:chatremedy/src/l10n/generated/l10n.dart';
import 'package:chatremedy/src/notification_service/notification_service.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lokalise_flutter_sdk/lokalise_flutter_sdk.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authorization/provider/user_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with WidgetsBindingObserver {
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    initApp();
    Future.delayed(const Duration(seconds: 2), () {
      navigateToNextScreen();
    });
  }

  initApp() {
    initMixpanel().then((value) {
      mixpanel!.track('Flutter Test Message');
    });
    WidgetsBinding.instance.addObserver(this);
    AdjustConfig config =
        AdjustConfig('sl0nmxnjuayo', AdjustEnvironment.sandbox);

    config.logLevel = AdjustLogLevel.verbose;
    Adjust.start(config);
    Lokalise.instance.update();
    notificationService.init(ref);
  }

  Mixpanel? mixpanel;

  Future<void> initMixpanel() async {
    mixpanel = await Mixpanel.init("a9fb771fadfa7c14d43cbf38ea927e00",
        trackAutomaticEvents: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        Adjust.onResume();
        break;
      case AppLifecycleState.paused:
        Adjust.onPause();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  navigateToNextScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token == null || token == '') {
      NotificationService().showNotification(
          "Register Today", "Have you created an account yet? - IT'S FREE!");
      NotificationService().checkAndSendNotifications();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => SelectionScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
        // MaterialPageRoute(builder: (context) => SelectionScreen()),
      );
    } else {
      await getLoggedInUser().then((value) {
        if (value == null) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  SelectionScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
            // MaterialPageRoute(builder: (context) => SelectionScreen()),
          );
        } else {
          if (value.user != null) {
            ref.read(userProvider.notifier).change(value);
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const WelcomeScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
              // MaterialPageRoute(builder: (context) => const WelcomeScreen())
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              Lt.of(context).title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
