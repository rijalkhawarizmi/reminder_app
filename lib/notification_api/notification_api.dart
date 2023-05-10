import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:reminder_app/pages/second_page.dart';
import 'dart:async';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  Future<void> _configuretime() async {
    tz.initializeTimeZones();
    final timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future init({bool schedule = false}) async {
    _configuretime();
     
    // for icon I take on link -> <a href="https://www.flaticon.com/free-icons/files-and-folders" title="files and folders icons">Files and folders icons created by manshagraphics - Flaticon</a>
    const android = AndroidInitializationSettings('app_icon');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
           Get.to(SecondPage(payload: payload ?? ""));
        });

    //when app closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      Get.to(SecondPage(payload: details.payload ?? ""));
    }
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          icon: 'app_icon',
          channelDescription: 'channel description',
          importance: Importance.max,
        ),
        iOS: IOSNotificationDetails());
  }

  static Future showNotification(
    {
    int id = 5,
    String? title,
    String? body,
    String? payload,
  }) async {
    _notifications.show(id, title, body, await _notificationDetails(),
        payload: payload);
         Get.to(SecondPage(payload: payload));
    //     await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondPage(payload: payload,)),
    // );
  }

  static Future showScheduledNotification(
      {required int id,
      String? title,
      String? body,
      String? payload,
      int? hour,
      int? minutes,
      int? date,
      int? month,
      int? year // required DateTime timer
      }) async {
    _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduledDaily(hour, minutes, date, month, year),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  static tz.TZDateTime _scheduledDaily(
      int? hour, int? minutes, int? date, int? month, int? year) {
    // print('halo ini time ${time.hour}${time.minute}${time.second}')
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, year ?? now.year,
        month ?? now.month, date ?? now.day, hour!, minutes!);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
