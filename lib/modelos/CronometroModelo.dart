import 'dart:async';
import 'package:flutter/material.dart';
import '../viewmodels/notificacion_viewmodel.dart';

class CronometroModelo extends ChangeNotifier {
  late Stopwatch _cronometro;
  late Timer _temporizador;
  List<Map<String, String>> vueltas = [];
  int _tiempoTotal = 0;
  bool corriendo = false;
  bool pausado = false;

  final NotificationViewModel _notificaciones = NotificationViewModel();
  Timer? _timerInactividad;

  CronometroModelo() {
    _cronometro = Stopwatch();
  }

  int get tiempoTranscurrido => _cronometro.elapsedMilliseconds;

  String get tiempoFormateado {
    return "${minutosSegundos} ${centesimas}";
  }

  String get minutosSegundos {
    final minutos = (_cronometro.elapsedMilliseconds ~/ 60000) % 60;
    final segundos = (_cronometro.elapsedMilliseconds ~/ 1000) % 60;
    return "${minutos.toString().padLeft(1, '0')}:${segundos.toString().padLeft(2, '0')}";
  }

  String get centesimas {
    final centesimas = (_cronometro.elapsedMilliseconds % 1000) ~/ 10;
    return centesimas.toString().padLeft(2, '0');
  }

  // Cambia entre iniciar, pausar o detener el cronómetro
  void cambiarCronometro() {
    if (_cronometro.isRunning) {
      pausarCronometro();
    } else {
      iniciarCronometro();
    }
  }

  // Inicia el cronómetro
  void iniciarCronometro() {
    if (!_cronometro.isRunning) {
      _cronometro.start();
      corriendo = true;
      pausado = false;
      _temporizador = Timer.periodic(Duration(milliseconds: 50), (temporizador) {
        notifyListeners();
      });
    }

    _notificaciones.showPersistent();
    _cancelarTimerInactividad();
  }

  // Pausa el cronómetro
  void pausarCronometro() {
    if (_cronometro.isRunning) {
      _cronometro.stop();
      corriendo = false;
      pausado = true;
      _temporizador.cancel();
      notifyListeners();
    }

    _iniciarTimerInactividad();
    _notificaciones.cancelPersistent();
  }

  // Detiene el cronómetro y reinicia
  void detenerCronometro() {
    _cronometro.stop();
    corriendo = false;
    pausado = false;
    _temporizador.cancel();
    reiniciarCronometro();

    _cancelarTimerInactividad();
    _notificaciones.cancelPersistent();
  }

  // Reinicia el cronómetro
  void reiniciarCronometro() {
    _cronometro.reset();
    vueltas.clear();
    _tiempoTotal = 0;
    notifyListeners();
  }

  // Agrega una vuelta al cronómetro
  void agregarVuelta() {
    if (_cronometro.isRunning) {
      int tiempoVuelta = _cronometro.elapsedMilliseconds;
      _tiempoTotal += tiempoVuelta;

      final tiempoVueltaStr = _formatearTiempo(tiempoVuelta);
      final tiempoTotalStr = _formatearTiempo(_tiempoTotal);

      vueltas.insert(0, {
        "vuelta": tiempoVueltaStr,
        "total": tiempoTotalStr,
      });

      _cronometro.reset();
      _notificaciones.showLap(tiempoVueltaStr, tiempoTotalStr);
    }

    notifyListeners();
  }

  // Inicia el temporizador de inactividad (10 segundos)
  void _iniciarTimerInactividad() {
    _cancelarTimerInactividad();
    _timerInactividad = Timer(Duration(seconds: 10), () {
      if (pausado) {
        _notificaciones.showInactivity();
      }
    });
  }

  // Cancela el temporizador de inactividad
  void _cancelarTimerInactividad() {
    _timerInactividad?.cancel();
  }

  // Formatea el tiempo
  String _formatearTiempo(int tiempo) {
    final minutos = (tiempo ~/ 60000) % 60;
    final segundos = (tiempo ~/ 1000) % 60;
    final centesimas = (tiempo % 1000) ~/ 10;

    return "${minutos.toString().padLeft(1, '0')}:${segundos.toString().padLeft(2, '0')}:${centesimas.toString().padLeft(2, '0')}";
  }
}
