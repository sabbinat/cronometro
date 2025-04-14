import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationViewModel {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  bool _initialized = false; // iniciliza solo una vez

  Future<void> initializeNotifications() async { //inicializa las notis
    if (_initialized) return;

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _plugin.initialize(initializationSettings);
    _initialized = true;
  }

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.status;

    if (!status.isGranted) {
      await Permission.notification.request(); // Solicita el permiso
    }
  }



  Future<void> showPersistent() async { //muestra una noti persistente que no se puede deslizar
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronómetro',
      channelDescription: 'Notificación persistente del cronómetro en ejecución',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true, //permite que sea permanente
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _plugin.show(
      0, //muestra la notificación con id 0
      'Cronómetro activo',
      'El cronómetro está en marcha.',
      notificationDetails,
    );
  }


  Future<void> cancelPersistent() async { //cancela la noti
    await _plugin.cancel(0);
  }

  // VUELTA REGISTRADA
  Future<void> showLap(String tiempoVuelta, String tiempoTotal) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronómetro',
      channelDescription: 'Notificación de vuelta registrada',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);
    await _plugin.show(
      1,
      'Vuelta registrada',
      'Vuelta: $tiempoVuelta\nTotal: $tiempoTotal',
      notificationDetails,
    );
  }

  //NOTI DE CRONOMETRO PAUSADO
  Future<void> showInactivity() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'cronometro_channel',
      'Cronómetro',
      channelDescription: 'Notificación por inactividad',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _plugin.show(
      2,
      '¿Seguimos?',
      'El cronómetro está pausado.',
      notificationDetails,
    );
  }
}
