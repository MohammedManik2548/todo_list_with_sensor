// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   NotificationService() {
//     final initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     final initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> showNotification(int id, String title, String body, DateTime scheduledDate) async {
//     final androidDetails = AndroidNotificationDetails(
//       'channelId',
//       'channelName',
//       channelDescription: 'To-Do Notifications',
//       importance: Importance.max,
//     );
//
//     final notificationDetails = NotificationDetails(android: androidDetails);
//
//     await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation(
//       id.to,
//       title,
//       body,
//       scheduledDate,
//       notificationDetails,
//     );
//   }
// }
