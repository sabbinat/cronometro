import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CronometroModelo.dart';

class CronometroVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final proveedor = Provider.of<CronometroModelo>(context);
    final progreso = (proveedor.tiempoTranscurrido % 60000) / 60000;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cronómetro',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF263238),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFF263238),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    value: progreso,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0AE6F8)),
                  ),
                ),
                Text(
                  proveedor.tiempoFormateado,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 40),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: proveedor.vueltas.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center,
                      child: ListTile(
                        subtitle: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Vuelta ${proveedor.vueltas.length - index} ',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                              TextSpan(
                                text: '  ${proveedor.vueltas[index]["vuelta"]}     |    ${proveedor.vueltas[index]["total"]}',
                                style: TextStyle(color: Colors.white54, fontSize: 12),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  proveedor.corriendo
                      ? CircleAvatar(
                    backgroundColor: Color(0x4527A0FF),
                    radius: 30,
                    child: IconButton(
                      icon: Icon(Icons.stop, size: 20, color: Colors.white),
                      onPressed: proveedor.detenerCronometro,
                    ),
                  )
                      : Container(),
                  const SizedBox(width: 40),
                  CircleAvatar(
                    backgroundColor: Colors.indigo[50],
                    radius: 45,
                    child: IconButton(
                      icon: Icon(proveedor.corriendo ? Icons.pause : Icons.play_arrow, size: 30, color: Color(
                          0xFF288895)),
                      onPressed: proveedor.cambiarCronometro,
                    ),
                  ),

                  const SizedBox(width: 40),
                  proveedor.corriendo
                      ? CircleAvatar(
                    backgroundColor: Color(0x4527A0FF),
                    radius: 30,
                    child: IconButton(
                      icon: Icon(Icons.refresh, size: 20, color: Colors.white),
                      onPressed: proveedor.agregarVuelta,
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
