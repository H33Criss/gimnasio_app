import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

void deleteConfirmDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('¿Estas seguro de borrar?'),
      content: const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In viverra, dui a pellentesque ultricies, nulla ligula mollis erat, vitae dictum lacus dui ut lacus. Nunc quis eros vestibulum, consectetur nibh quis, accumsan risus. Nunc neque massa, placerat in nunc ac, ultricies gravida libero. Suspendisse egestas tincidunt orci, eu blandit neque pulvinar vel. Fusce malesuada urna metus, volutpat pellentesque urna ultrices a. Duis id fringilla lacus. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => context.pop(),
          child: const Text('Aceptar'),
        )
      ],
    ),
  );
}
