import 'package:chatremedy/firebase_options.dart';
import 'package:chatremedy/src/features/splash_screen/view/splash_screen.dart';
import 'package:chatremedy/src/l10n/generated/l10n.dart';
import 'package:chatremedy/src/utils/base_url.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:lokalise_flutter_sdk/lokalise_flutter_sdk.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor, // status bar color
  ));
  await Lokalise.init(
    projectId: '419979696638cd3d35f0d4.65200732', // Fill with your project id
    sdkToken:
        '18c9e8dbc56e4e24b3aa98a6276f54e57d36', // Fill with your SDK token
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterUxcam
        .optIntoSchematicRecordings(); // Confirm that you have user permission for screen recording
    FlutterUxConfig config = FlutterUxConfig(
        userAppKey: "e7achl792sxm9x6", enableAutomaticScreenNameTagging: false);
    FlutterUxcam.startWithConfiguration(config);
    return MaterialApp(
      builder: (context, child) {
        return StreamChat(client: client, child: child);
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: Lt.localizationsDelegates,
      supportedLocales: Lt.supportedLocales,
      onGenerateTitle: (context) => Lt.of(context).title,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
