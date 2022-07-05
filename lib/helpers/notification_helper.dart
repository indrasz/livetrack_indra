import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:livetrack_indra/repositories/auth_repository.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.high,
);

/// Handle all notification service
class NotificationHelper {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late NotificationDetails _platformChannelSpecifics;

  /// Initialize notification service
  Future<void> initialize() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _selectNotification,
    );

    await _requestPermissionNotification();

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'user_id_1',
      'user',
      channelDescription: 'Users application',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    _platformChannelSpecifics =
        const NotificationDetails(android: androidPlatformChannelSpecifics);
  }

  /// Manually show notification
  Future show(
    int id,
    String? title,
    String? body,
    NotificationDetails? notificationDetails, {
    String? payload,
  }) async {
    await _flutterLocalNotificationsPlugin
        .show(id, title, body, _platformChannelSpecifics, payload: payload);
  }

  Future<void> _requestPermissionNotification() async {
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel(androidChannel);
    } else if (Platform.isIOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  Future _selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await GetIt.I<NavigationHelper>().push<void>(const MainRoute());
  }

  static Future _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // await showDialog<void>(
    //   context: GetIt.I<AppRouter>().navigatorKey.currentContext!,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title ?? 'Notification'),
    //     content: Text(body ?? ''),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await GetIt.I<NavigationHelper>().push<void>(const MainRoute());
    //         },
    //         child: const Text('Ok'),
    //       )
    //     ],
    //   ),
    // );
  }
}
