import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static void requestPermissions() {
    _notification
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    _notification
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            'channel description',
            importance: Importance.max
        ),
        iOS: IOSNotificationDetails()
    );
  }

  static getDateTimeTz(DateTime dateTime) => tz.TZDateTime.from(dateTime, tz.local);

  static Future notificationDetailsWithSchedule() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            'channel description',
            importance: Importance.max
        ),
        iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('app_icon');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);

    if (initScheduled) {
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation(DateTime.now().timeZoneName));
    }

    await _notification.initialize(
        settings,
        onSelectNotification: (payload) async {
          onNotifications.add(payload);
        }
    );
  }

  static Future showNotificationWithSchedule({
    int id = 0,
    String? title,
    String? body,
    required tz.TZDateTime scheduledDate,
    String? payload}) async =>
      _notification.zonedSchedule(
          id,
          title,
          body,
          scheduledDate,
          await notificationDetails(),
          androidAllowWhileIdle: true,
          payload: payload,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);

  static Future removeNotification(int notificationId) async => _notification.cancel(notificationId);

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload}) async =>
      _notification.show(
          id,
          title,
          body,
          await notificationDetails(),
          payload: payload);
}