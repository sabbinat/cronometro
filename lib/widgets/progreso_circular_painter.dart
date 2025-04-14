import 'package:flutter/material.dart';

class ProgresoCircularPainter extends CustomPainter {
  final double progreso;
  final Color color;
  final double strokeWidth;

  ProgresoCircularPainter({
    required this.progreso,
    required this.color,
    this.strokeWidth = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final fondoPaint = Paint()
      ..color = const Color(0xFF1A1B44)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final progresoPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Fondo
    canvas.drawCircle(center, radius, fondoPaint);

    // Progreso
    final angle = 2 * 3.141592653589793 * progreso;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      angle,
      false,
      progresoPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
