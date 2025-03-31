# Proyecto Cronómetro en Flutter

<div style="display: flex; align-items: center;">
  <img src="https://github.com/user-attachments/assets/057494c1-d870-4d6c-b44c-8458d3c13e6e" width="150" style="margin-right: 10px;">
  <p>Este es un proyecto simple de cronómetro desarrollado en Flutter. Permite iniciar, pausar, detener y registrar vueltas.</p>
</div>


## Características

- **Iniciar/Detener Cronómetro**: Permite iniciar o detener el cronómetro.
- **Pausar/Continuar Cronómetro**: Si el cronómetro está en pausa, puedes reanudarlo.
- **Agregar Vueltas**: Durante la ejecución del cronómetro, puedes agregar vueltas y ver su tiempo.
- **Interfaz Visual**: La interfaz muestra el tiempo transcurrido en formato `MM:SS.mmm`, así como una barra de progreso circular que indica el tiempo transcurrido.

## Estructura del Proyecto

- `CronometroModelo.dart`: Contiene la lógica del cronómetro, gestionando el tiempo transcurrido y las vueltas.
- `CronometroVisual.dart`: La interfaz de usuario que muestra el cronómetro y las vueltas registradas.
