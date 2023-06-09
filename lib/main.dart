import 'package:get/get.dart';
import 'package:recetas/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recetas/settings/theme_style.dart';
import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:recetas/settings/theme_settings.dart';
import 'package:recetas/settings/account_setting.dart';
import 'package:recetas/screens/onboarding_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:recetas/firebase/firebase_notifications.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  FireNotifications.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recetas para estudiantes',
      routes: getApplicationRoutes(),
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      home:OnBoardingScreen(),
      themeMode: ThemeSettings().getThemeMode(),
    );
  }
}


