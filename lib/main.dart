import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CronometroModelo.dart';
import 'CronometroVisual.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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



