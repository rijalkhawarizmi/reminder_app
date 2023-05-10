
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:reminder_app/second_page.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;


// class Notif{
//   FlutterLocalNotificationsPlugin
//   flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin(); //

//   initializeNotification() async {
//     tz.initializeTimeZones();
//  const IOSInitializationSettings initializationSettingsIOS =
//      IOSInitializationSettings(
//          requestSoundPermission: false,
//          requestBadgePermission: false,
//          requestAlertPermission: false,
//         //  onDidReceiveLocalNotification: onDidReceiveLocalNotification
//      );


//  final AndroidInitializationSettings initializationSettingsAndroid =
//      AndroidInitializationSettings("@mipmap/ic_launcher");

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//        android:initializationSettingsAndroid,
       
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onSelectNotification: selectNotification);

//   }

//     Future selectNotification(String? payload) async {
//     if (payload != null) {
//       print('notification payload: $payload');
//     } else {
//       print("Notification Done");
//     }
    
//   }

//   displayNotification({required String title, required String body}) async {
//     print("doing test");
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'your channel id', 'your channel name', channelDescription: 'your channel description',
//         importance: Importance.max, priority: Priority.high);
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platformChannelSpecifics = new NotificationDetails(
//         android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'You change your theme',
//       'You changed your theme back !',
//       platformChannelSpecifics,
//       payload: 'It could be anything you pass',
//     );
//   }
//   scheduledNotification() async {
//      await flutterLocalNotificationsPlugin.zonedSchedule(
//          0,
//          'scheduled title',
//          'theme changes 5 seconds ago',
//          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
//          const NotificationDetails(
//              android: AndroidNotificationDetails('your channel id',
//                  'your channel name', channelDescription: 'your channel description')),
//          androidAllowWhileIdle: true,
//          uiLocalNotificationDateInterpretation:
//              UILocalNotificationDateInterpretation.absoluteTime);

//    }
// }