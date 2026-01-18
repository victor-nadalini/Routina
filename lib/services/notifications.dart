import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() => _notificationService;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings darwinInitializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: darwinInitializationSettingsIOS,
        );
    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> agendarNotificacaoRecorrente({
    String? titulo,
    String? corpo,
    required int minutos,
  }) async {
    await notificationsPlugin.zonedSchedule(
      1,
      "Não se esqueça de nos!!!",
      "de uma olhada nas suas tarefas!!!",
      tz.TZDateTime.now(tz.local).add(Duration(minutes: minutos)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'ID_DO_CANAL_LEMBRETES_FIXOS',
          'Lembretes Fixos',
          importance: Importance.low,
          priority: Priority.low,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
