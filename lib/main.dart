import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Screens
import './screens/auth_screen.dart';
import '../screens/notification_screen.dart';
/// Themes
import '../utils/my_themes.dart';
import 'api/notification_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: MyThemes.lightTheme,
      home: const NotificationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
