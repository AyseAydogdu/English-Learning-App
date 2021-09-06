import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    //String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(currentTimeZone));
    //
    // this ic_launcher is a image in  android/app/src/main/res/drawable
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("app_notification_icon");
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    this.flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "your channel",
      "channel name",
      "channel descrption",
      priority: Priority.max,
      importance: Importance.max,
    );
    // channel IOS
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: ,
      // macOS: ,
    );
    await this.flutterLocalNotificationPlugin.show(
          0,
          "this is a notification",
          "inside the notification",
          platformChannelSpecifics,
        );
  }

  Future<void> scheduleWeeklyNotification() async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id",
        "name",
        "description",
        priority: Priority.max,
        importance: Importance.max,
      ),
    );

    await this.flutterLocalNotificationPlugin.zonedSchedule(
          0,
          "notification for Tomorrow",
          "body",
          _netxinstanceofFryday(),
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
  }

  tz.TZDateTime _netxinstanceofFryday() {
    tz.TZDateTime scheduleDate = _nextIntanceOfTenAM();
    while (scheduleDate.weekday != DateTime.friday) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }

  tz.TZDateTime _nextIntanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 7, 34);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }

  tz.TZDateTime _nextIntanceOf(String hour, String minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, int.parse(hour), int.parse(minute));
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> scheduleNext5SecondsNotification() async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id",
        "name",
        "description",
        priority: Priority.max,
        importance: Importance.max,
      ),
    );
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = now.add(Duration(seconds: 5));
    await this.flutterLocalNotificationPlugin.zonedSchedule(
          0,
          "notification for 5 seconds",
          "in 5 seconds",
          scheduleDate,
          details,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
  }

  Future<void> scheduleDailyTenAMNotification() async {
    await this.flutterLocalNotificationPlugin.zonedSchedule(
        0,
        'İngilizce Öğrenme Zamanı',
        'Hadi hemen başla',
        _nextIntanceOfTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> scheduleDailyNotification(String hour, String minute) async {
    await this.flutterLocalNotificationPlugin.zonedSchedule(
        0,
        'İngilizce Öğrenme Zamanı',
        'Hadi hemen başla',
        _nextIntanceOf(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily notification channel id',
              'daily notification channel name',
              'daily notification description'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationPlugin.cancel(id);

    Future<void> cancelAllNotification() async {
      await flutterLocalNotificationPlugin.cancelAll();
    }
  }
}
