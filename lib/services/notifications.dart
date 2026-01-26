import 'dart:io';
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

    if (Platform.isAndroid) {
      notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }
  }

  Future<void> testeImediato() async {
  await notificationsPlugin.show(
    0,
    "Teste de Conexão",
    "Se você está lendo isso, o plugin está OK!",
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'canal_teste', 'Teste',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
}

  Future<void> agendarNotificacaoRecorrente({
    String? titulo,
    String? corpo,
    required int minutos,
  }) async {
    await notificationsPlugin.periodicallyShow( // esse metodo so permite uma execução vou mudalo para o que permite de hora em hora
      1,
      "Não se esqueça de nos!!!",
      "de uma olhada nas suas tarefas!!!",
      RepeatInterval.everyMinute,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'ID_DO_CANAL_LEMBRETES_FIXOS',
          'Lembretes Fixos',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
