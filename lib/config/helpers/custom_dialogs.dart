import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/providers.dart';

import 'package:gym_app/src/screens/reservas/widgets/confirm_dialog.dart';

void confirmDialog(
    BuildContext context, int fila, int columna, List<DateTime> fechas) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ConfirmDialog(fila: fila, columna: columna, fechas: fechas);
      });
}

void deleteConfirmDialog(
    BuildContext context, ReservaProvider provider, ReservaModel reserva) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('¿Estas seguro de borrar?'),
      content: const Text(
          'Realizar esta accion borrará permanentemente la reserva seleccionada. Presionar aceptar si lo desea.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () async {
            if (!provider.loading) {
              print('Borrar');
              provider.toggleLoad();
              await provider.deleteReserva(reserva.idDoc ?? '').then((a) {
                provider.toggleLoad();
                context.pop();
              });
            }
          },
          child: provider.loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : const Text('Aceptar'),
        )
      ],
    ),
  );
}

void bloqueadoDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Dia bloqueado'),
      content: const Text(
          'Es demasiado pronto para poder reservar aquí. Intentalo cuando queden al menos 24 para este dia.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

void huboReservaDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Aqui reservaste'),
      content: const Text(
          'Esta fue una reserva que realizaste en la semana, para mas detalles sobre esta dirigite a "Mis horas".'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

void habraReservaDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Reserva especial'),
      content: const Text(
          'Esta reserva te fue añadida por un administrador o profesor.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

void concluidoDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Dia concluido'),
      content: const Text('No puedo reservar aqui. Este dia ya ha concluido.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

void consultaDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Consulta en el gimnasio'),
      content: const Text(
          'No puedes realizar una reserva el mismo dia por aquí. Si aun asi quieres asistir, consulta directamente en el gimnasio.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

void reservadoDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Reserva Ingresada'),
      content: const Text(
          'Quedan 24 horas o menos para esta reserva. Consulta los detalles de esta reserva en el menu "Mis Horas" en la pagina principal.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

void onePerDayDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Maximo 1 reserva por día'),
      content: const Text(
          'Ya haz hecho una reserva en este dia, no puede tener 2 activas. Si aun quieres este bloque, elimina la ya existente y vuelve aquí.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}
