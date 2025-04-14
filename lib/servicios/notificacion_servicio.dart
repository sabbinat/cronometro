import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showSimpleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'simple_notification_channel',
      'Simple Notifications',
      channelDescription: 'Este canal é para notificações simples',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Título da Notificação',
      'Esta é uma notificação simples.',
      platformChannelSpecifics,
    );
  }


  Future<void> showPersistentNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'persistent_channel',
      'Cronómetro Activo',
      channelDescription: 'Notificación persistente mientras el cronómetro está activo',
      importance: Importance.low,
      priority: Priority.low,
      icon: '@mipmap/ic_launcher',
      ongoing: true, // Notificación persistente
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      1, // ID distinto del simple
      'Cronómetro en marcha',
      'El cronómetro está activo...',
      notificationDetails,
    );
  }

  Future<void> showLapNotification(String tiempoVuelta, String tiempoTotal) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'lap_channel',
      'Vueltas',
      channelDescription: 'Notificación al registrar una vuelta',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      2,
      'Nueva vuelta registrada',
      'Vuelta: $tiempoVuelta - Total: $tiempoTotal',
      notificationDetails,
    );
  }

  Future<void> showInactivityNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'inactividad_channel',
      'Inactividad',
      channelDescription: 'Sugerencia de retomar el cronómetro',
      importance: Importance.max,
      priority: Priority.max,
      icon: '@mipmap/ic_launcher',
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      3,
      '¿Retomar cronómetro?',
      'Estás en pausa hace 10 segundos. ¡Vamos!',
      notificationDetails,
    );
  }

  Future<void> cancelPersistentNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(1);
  }

}