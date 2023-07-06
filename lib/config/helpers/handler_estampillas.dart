import 'package:flutter/material.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/reservas/widgets/estampillas_reservas.dart';
import 'package:gym_app/src/shared/data/semana_data.dart';

ResponseHandleEstampilla handleEstampilla(
    ReservaModel? r, int j, int i, ReservaProvider provider) {
  //i -> la fila, tiene sincronia con el bloque
  //j -> la columna, tiene sincronia con el dia
  Widget estampilla = const EstampillasReservas(
    estampilla: Estampillas.vacio,
  );
  Estampillas dialog = Estampillas.reservado;
  final int diaActual =
      provider.diasSemanaSoloNumero.indexOf(provider.diaActual);

  bool reservado = r?.bloque == i && r?.dia == j;

  //Reserva realizada en los tiempos correctos
  if (reservado && r != null) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.reservado,
    );
  }
  //Un dia que ha concluido, ya ha pasado
  if (j < diaActual && reservado && r != null) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.huboReserva,
    );
    dialog = Estampillas.huboReserva;
  }
  //Una reserva que coincide con el dia actual
  if (j == diaActual && reservado && r != null) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.reservaEnCurso,
    );
    dialog = Estampillas.reservaEnCurso;
  }
  //Si hay una reserva en el futuro con mas 2 dias de lejania
  if (j >= diaActual + 2 && reservado && r != null) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.habraReserva,
    );
    dialog = Estampillas.habraReserva;
  }
  //Pedir reservas en el mismo dia
  if (j == diaActual && !reservado) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.consulta,
    );
    dialog = Estampillas.consulta;
  }
  //Una reserva vieja en la semana
  if (j < diaActual && !reservado) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.concluido,
    );
    dialog = Estampillas.concluido;
  }

  //Se bloquea el reservas para dia que estan mas de 2 dias alejas del dia actual
  if (j >= diaActual + 2 && !reservado) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.bloqueado,
    );
    dialog = Estampillas.bloqueado;
  }

  return ResponseHandleEstampilla(estampilla: estampilla, dialog: dialog);
}
