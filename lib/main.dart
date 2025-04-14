import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modelos/CronometroModelo.dart';
import 'widgets/CronometroVisual.dart';
import 'viewmodels/notificacion_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NotificationViewModel _notificationViewModel;

  @override
  void initState() {
    super.initState();
    _notificationViewModel = NotificationViewModel();
    _notificationViewModel.initializeNotifications();
    _notificationViewModel.requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CronometroModelo(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CronometroVisual(),
      ),
    );
  }
}
