import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FireNotifications {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static Future _backgroundHandler(RemoteMessage message) async {
    print('onBackground Handler ${message.messageId}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      String action = jsonEncode(message.data);
      flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification!.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'recipe_news',
              'Recetas',
              priority: Priority.high,
              importance: Importance.max,
              setAsGroupSummary: true,
              styleInformation: DefaultStyleInformation(true, true),
              //largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              channelShowBadge: true,
              autoCancel: true,
              icon: '@drawable/notification_icon',
            ),
          ),
          payload: action);
    }
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print('onMessageHandler Handler ${message.messageId}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      String action = jsonEncode(message.data);
      flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification!.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'recipe_news',
              'Recetas',
              priority: Priority.high,
              importance: Importance.max,
              setAsGroupSummary: true,
              styleInformation: DefaultStyleInformation(true, true),
              //largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              channelShowBadge: true,
              autoCancel: true,
              icon: '@drawable/notification_icon',
            ),
          ),
          payload: action);
    }
  }

  static Future _onOpenHandlerMessage(RemoteMessage message) async {
    print('onMessageOpenApp ${message.messageId}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      String action = jsonEncode(message.data);
      flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification!.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'recipe_news',
              'Recetas',
              priority: Priority.high,
              importance: Importance.max,
              setAsGroupSummary: true,
              styleInformation: DefaultStyleInformation(true, true),
              //largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              channelShowBadge: true,
              autoCancel: true,
              icon: '@drawable/notification_icon',
            ),
          ),
          payload: action);
    }
  }

  static Future initializeApp() async {
    if (!kIsWeb) {
      await FirebaseMessaging.instance.requestPermission();
    }
    token = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $token');

    // Inicializa flutterLocalNotificationsPlugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _initializeLocalNotifications();

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenHandlerMessage);
  }

  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@drawable/notification_icon'); // Reemplaza el nombre de tu icono de lanzador
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin!.initialize(initializationSettings);
  }
}
