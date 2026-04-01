import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
      

  /// Initialize notification service
 static Future<void> init() async {
 
  tz.initializeTimeZones();
  
  // Access the name property from the TimezoneInfo object
 final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    final String timeZoneName = timezoneInfo.identifier; // Use identifier here

    print("DEBUG: Setting timezone to $timeZoneName");
    
    // 2. Set the local location so 'tz.local' works correctly
    tz.setLocalLocation(tz.getLocation(timeZoneName));
     print("Current TZ Time: ${tz.TZDateTime.now(tz.local)}");

  const AndroidInitializationSettings android =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings settings =
      InitializationSettings(android: android);

  await _notifications.initialize(settings: settings);

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'task_channel',
    'Task Notifications',
    description: 'Reminder for tasks',
    importance: Importance.max,
    
  );

  await _notifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
}
 static Future<bool> requestExactAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.isDenied) {
    final result = await Permission.scheduleExactAlarm.request();
    return result.isGranted;
  }
  return true;
}
static Future<void> showInstantNotification() async {
  const NotificationDetails details = NotificationDetails(
    android: AndroidNotificationDetails('task_channel', 'Test', importance: Importance.max, priority: Priority.high)
  );
  await _notifications.show(title:  "Test",body: "It works!",notificationDetails:  details, id: 99);
}


 static Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}
//   /// Schedule a notification
//  static Future<void> scheduleNotification(
//     int id, String title, String body, DateTime scheduledTime) async {
  
//   if (scheduledTime.isBefore(DateTime.now())) {
//     print("Notification skipped: Time is in the past");
//     return;
//   }

//   await _notifications.zonedSchedule(
//     id: id,
//     title: title,
//     body: body,
//     // Ensure we are using the local timezone set in init()
//     scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
//    notificationDetails: const NotificationDetails(
//   android: AndroidNotificationDetails(
//     'task_channel',
//     'Task Notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//     fullScreenIntent: true, // Helps wake the screen
//     category: AndroidNotificationCategory.reminder, // Tells Android it's a reminder
//     playSound: true,

//   ),
// ),
//     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // Use exact since you have permissions logic
//    // Add this line
//   );
// }
/// Schedule a notification
static Future<void> scheduleNotification(
 int id, String title, String body, DateTime scheduledTime) async {

  try {
    if (scheduledTime.isBefore(DateTime.now())) {
      print("DEBUG: Notification skipped - Time is in the past ($scheduledTime)");
      return;
    }

    final tzTime = tz.TZDateTime.from(scheduledTime, tz.local);
    print("DEBUG: Attempting to schedule ID: $id at $tzTime");

    await _notifications.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzTime,
      notificationDetails: const NotificationDetails( // Correct constructor for v21
        android: AndroidNotificationDetails(
          'task_channel_v2', // Changed ID to bypass potential Android cache
          'Task Notifications',
          channelDescription: 'Reminder for tasks',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          category: AndroidNotificationCategory.reminder,
          playSound: true,
        ),
      ),
      // Use exactAllowWhileIdle for timely reminders
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, 
    );

    print("DEBUG: Successfully scheduled notification $id");

  } catch (e, stack) {
    print("DEBUG ERROR: Failed to schedule: $e");
    print("DEBUG STACKTRACE: $stack");
    
    // Auto-fallback if Exact Alarm is blocked by Android settings
    if (e.toString().contains("exact_alarm")) {
       print("DEBUG: Falling back to inexact schedule mode...");
       await _notifications.zonedSchedule(
         id: id,
         title: title,
         body: body,
         scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
         notificationDetails: const NotificationDetails(
           android: AndroidNotificationDetails('task_channel_v2', 'Task Notifications'),
         ),
         androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
       );
    }
  }
}

  /// Cancel a single notification
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id:id);
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// Update a notification (cancel old & schedule new)
  static Future<void> updateNotification(
      int id, String title, String body, DateTime newTime) async {
    await cancelNotification(id);
    await scheduleNotification(id, title, body, newTime);
  }
}