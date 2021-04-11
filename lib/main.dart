import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shoesfyp2/screens/landing_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'push_notification_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  Widget build(BuildContext context) {
    final pushNotificationService =
        PushNotificationService(_firebaseMessaging, context, navigatorKey);
    pushNotificationService.initialise();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          accentColor: Color(0xFFFF1E00)),
      home: LandingPage(),
    );
  }
}
