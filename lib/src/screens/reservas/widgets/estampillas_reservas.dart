import 'package:flutter/material.dart';

enum Estampillas {
  reservado,
  vacio,
  bloqueado,
  concluido,
  huboReserva,
  habraReserva,
  consulta,
  reservaEnCurso,
  onePerDay,
}

class EstampillasReservas extends StatelessWidget {
  final Estampillas estampilla;

  const EstampillasReservas({super.key, required this.estampilla});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    switch (estampilla) {
      case Estampillas.bloqueado:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_clock_outlined,
              color: colors.primary,
              size: 28,
            ),
            Text('Bloqueado', style: textStyles.labelSmall)
          ],
        );
      case Estampillas.reservado:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.green,
              size: 28,
            ),
            Text('Reservado', style: textStyles.labelSmall)
          ],
        );
      case Estampillas.reservaEnCurso:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.library_add_check_outlined,
              color: Colors.green,
              size: 28,
            ),
            Text('En curso', style: textStyles.labelSmall)
          ],
        );
      case Estampillas.concluido:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock,
              color: Colors.grey,
              size: 28,
            ),
            Text('Concluido', style: textStyles.labelSmall)
          ],
        );
      case Estampillas.huboReserva:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_person_outlined,
              color: Colors.grey,
              size: 28,
            ),
            Text('Reservaste', style: textStyles.labelSmall)
          ],
        );
      case Estampillas.habraReserva:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.health_and_safety_outlined,
              color: colors.onPrimaryContainer,
              size: 28,
            ),
            Text('Te', style: textStyles.labelSmall),
            Text('reservaron', style: textStyles.labelSmall),
          ],
        );
      case Estampillas.consulta:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mark_unread_chat_alt_outlined,
              color: colors.primary,
              size: 28,
            ),
            Text('Consulta', style: textStyles.labelSmall)
          ],
        );
      case Estampillas.onePerDay:
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.deselect_outlined,
              color: Colors.grey,
            )
          ],
        );
      default:
        return Container();
    }
  }
}
