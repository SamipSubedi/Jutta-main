import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoesfyp2/push_notification_message.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;
  final BuildContext context;
  PushNotificationMessage notification;
  SharedPreferences preferences;
  GlobalKey<NavigatorState> state;

  PushNotificationService(this._fcm, this.context, this.state);

  Future initialise() async {
    preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("device_token");
    print("token: $token");

    if (Platform.isIOS) {
      _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
        if (token == null) _saveDeviceToken();
      });
      _fcm.requestNotificationPermissions(const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true));
    } else {
      if (token == null) _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        if (Platform.isAndroid) {
          notification = PushNotificationMessage(
            title: message['notification']['title'],
            body: message['notification']['body'],
          );
        }
        if (Platform.isIOS) {
          notification = PushNotificationMessage(
            title: message['aps']['alert']['title'],
            body: message['aps']['alert']['body'],
          );
        }
        showSimpleNotification(Container(child: Text(notification.body)),
            position: NotificationPosition.top,
            background: Colors.orangeAccent.withOpacity(0.8));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _serializeAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _serializeAndNavigate(message);
      },
    );
  }

  _saveDeviceToken() async {
    String token = await _fcm.getToken();
    if (token != null) {
      print("FirebaseMessaging token: $token");
      preferences.setString("device_token", token);
    }
  }

  _serializeAndNavigate(Map<String, dynamic> message) {
    String view = message['data']['view'];
    print("view: $view");

    if (view != null) {
      state.currentState.pushNamed(view);
    }
  }
}
