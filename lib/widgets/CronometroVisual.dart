import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modelos/CronometroModelo.dart';
import '../widgets/progreso_circular_painter.dart';


class CronometroVisual extends StatelessWidget {
  const CronometroVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final proveedor = Provider.of<CronometroModelo>(context);
    final progreso = (proveedor.tiempoTranscurrido % 60000) / 60000;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: const Text(
            'Cronómetro',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color(0xFF1D1D28),
        foregroundColor: Colors.white,
      ),
        backgroundColor: const Color(0xFF1D1D28),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            // Cronómetro visual
            Semantics(
              label: 'Tiempo actual del cronómetro: ${proveedor.tiempoFormateado}',
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF02021F).withAlpha(77),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: ProgresoCircularPainter(
                        progreso: progreso,
                        color: const Color(0xFF29E2F1),
                        strokeWidth: 12,
                      ),
                    ),
                  ),

                  // Tiempo en el centro
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        proveedor.minutosSegundos,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text(
                          proveedor.centesimas,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Lista de vueltas
            SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Semantics(
                    label: 'Lista de vueltas registradas',
                    child: ListView.builder(
                      itemCount: proveedor.vueltas.length >= 2 ? 2 : proveedor.vueltas.length,
                      itemBuilder: (context, index) {
                        final numero = proveedor.vueltas.length - index;
                        final vuelta = proveedor.vueltas[index]["vuelta"];
                        final total = proveedor.vueltas[index]["total"];

                        final isLastVuelta = index == 0;
                        final textStyle = isLastVuelta
                            ? const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )
                            : const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        );

                        return Align(
                          alignment: Alignment.center,
                          child: Semantics(
                            label: 'Vuelta $numero, tiempo: $vuelta, tiempo total: $total',
                            child: ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              contentPadding: EdgeInsets.zero,
                              subtitle: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'Vuelta $numero ', style: textStyle),
                                    TextSpan(text: '  $vuelta     |    $total', style: textStyle),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 70),

            // Botones de control
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (proveedor.corriendo || proveedor.pausado)
                    Semantics(
                      button: true,
                      enabled: proveedor.corriendo,
                      label: 'Detener cronómetro',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(0, 0, 0, 0.2),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF3B868C),
                          radius: 30,
                          child: IconButton(
                            tooltip: 'Detener cronómetro',
                            icon: const Icon(Icons.stop, size: 20, color: Colors.white),
                            onPressed: proveedor.detenerCronometro,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 40),

                  // Botón principal
                  Semantics(
                    button: true,
                    enabled: true,
                    label: proveedor.corriendo ? 'Pausar cronómetro' : 'Iniciar cronómetro',
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 0.2),
                            blurRadius: 15,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF29E2F1),
                          radius: 50,
                          child: IconButton(
                            tooltip: proveedor.corriendo ? 'Pausar cronómetro' : 'Iniciar cronómetro',
                            icon: Icon(
                              proveedor.corriendo ? Icons.pause : Icons.play_arrow,
                              size: 40,
                              color: Color(0xFF121331),
                            ),
                            onPressed: proveedor.cambiarCronometro,
                            iconSize: 40,
                          ),
                        )
                    ),
                  ),

                  const SizedBox(width: 40),

                  if (proveedor.corriendo)
                    Semantics(
                      button: true,
                      enabled: proveedor.corriendo,
                      label: 'Registrar nueva vuelta',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(0, 0, 0, 0.2),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF32767C),
                          radius: 30,
                          child: IconButton(
                            tooltip: 'Registrar vuelta',
                            icon: const Icon(Icons.refresh, size: 20, color: Colors.white),
                            onPressed: proveedor.agregarVuelta,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
