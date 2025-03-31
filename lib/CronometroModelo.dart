import 'dart:async';
import 'package:flutter/material.dart';

class CronometroModelo extends ChangeNotifier {
  late Stopwatch _cronometro;
  late Timer _temporizador;
  List<Map<String, String>> vueltas = [];
  int _tiempoTotal = 0;
  bool corriendo = false;
  bool pausado = false;

  CronometroModelo() {
    _cronometro = Stopwatch();
  }

  int get tiempoTranscurrido=> _cronometro.elapsedMilliseconds;

  String get tiempoFormateado {
    return _formatearTiempo(_cronometro.elapsedMilliseconds);
  }

  String _formatearTiempo(int milisegundos) {
    final segundos = (milisegundos / 1000) % 60;
    final minutos = (milisegundos / (1000 * 60)) % 60;
    return "${minutos.toInt().toString().padLeft(2, '0')}:${segundos.toStringAsFixed(2).padLeft(5, '0')}";
  }

  void cambiarCronometro() {
    if (_cronometro.isRunning) {
      pausarCronometro();
    } else {
      iniciarCronometro();
    }
  }

  void iniciarCronometro() {
    if (!_cronometro.isRunning) {
      _cronometro.start();
      corriendo = true;
      pausado = false;
      _temporizador = Timer.periodic(Duration(milliseconds: 50), (temporizador) {
        notifyListeners();
      });
    }
  }

  void pausarCronometro() {
    if (_cronometro.isRunning) {
      _cronometro.stop();
      corriendo = false;
      pausado = true;
      _temporizador.cancel();
      notifyListeners();
    }
  }

  void detenerCronometro() {
    _cronometro.stop();
    corriendo = false;
    pausado = false;
    _temporizador.cancel();
    reiniciarCronometro();
  }

  void reiniciarCronometro() {
    _cronometro.reset();
    vueltas.clear();
    _tiempoTotal = 0;
    notifyListeners();
  }

  void agregarVuelta() {
    if (_cronometro.isRunning) {
      int tiempoVuelta = _cronometro.elapsedMilliseconds;
      _tiempoTotal+= tiempoVuelta;
      vueltas.insert(0, {
        "vuelta": _formatearTiempo(tiempoVuelta),
        "total": _formatearTiempo(_tiempoTotal),
      });
      _cronometro.reset();
    }
    notifyListeners();
  }
}
