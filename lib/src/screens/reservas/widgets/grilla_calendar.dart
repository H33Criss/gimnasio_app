import 'package:flutter/material.dart';
import 'package:gym_app/config/helpers/custom_dialogs.dart';
import 'package:gym_app/config/helpers/validators_date.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/reservas/widgets/confirm_dialog.dart';
import 'package:gym_app/src/screens/reservas/widgets/estampillas_reservas.dart';
import 'package:provider/provider.dart';

class GrillaCalendar extends StatelessWidget {
  final double heightGrilla;
  final double widthGrilla;
  const GrillaCalendar(
      {super.key, required this.heightGrilla, required this.widthGrilla});

  @override
  Widget build(BuildContext context) {
    List<int> filas = List<int>.generate(7, (index) => index);
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final reservaProvider = context.watch<ReservaProvider>();
    final userProvider = context.watch<UserProvider>();
    return StreamBuilder(
      stream: reservaProvider.getListOfReservas(userProvider.user!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) CircularProgressIndicator(color: colors.primary);
        List<ReservaModel> reservas = snapshot.data ?? [];
        return Column(
          children: filas.map((i) {
            List<int> columnas = List<int>.generate(5, (index) => index);
            return Row(
              children: columnas.map((j) {
                return InkWell(
                  splashColor: colors.primary.withOpacity(.3),
                  onTap: () {
                    final response = checkIfExistAnyReserva(reservas, i, j);
                    if (!response.existsReserva) {
                      confirmDialog(
                        context,
                        i,
                        j,
                        reservaProvider.diasSemanaFechaCompleta,
                      );
                    }
                  },
                  onLongPress: () async {
                    final response = checkIfExistAnyReserva(reservas, i, j);
                    if (response.existsReserva && response.reserva != null) {
                      await reservaProvider
                          .deleteReserva(response.reserva?.idDoc ?? '');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colors.primary,
                        width: .1,
                      ),
                    ),
                    width: size.width * 0.85 / 5,
                    height: heightGrilla,
                    // child: Container(),
                    child: _handleEstampilla(reservas, j, i, reservaProvider),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        );
      },
    );
  }
}

Widget _handleEstampilla(
    List<ReservaModel> reservas, int j, int i, ReservaProvider provider) {
  //i -> la fila, tiene sincronia con el bloque
  //j -> la columna, tiene sincronia con el dia
  Widget estampilla = const EstampillasReservas(
    estampilla: Estampillas.vacio,
  );
  final int diaActual =
      provider.diasSemanaSoloNumero.indexOf(provider.diaActual);

  final response = checkIfExistAnyReserva(reservas, i, j);
  final r = response.reserva;
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
  }
  //Una reserva que coincide con el dia actual
  if (j == diaActual && reservado && r != null) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.reservaEnCurso,
    );
  }
  //Si hay una reserva en el futuro con mas 2 dias de lejania
  if (j >= diaActual + 2 && reservado && r != null) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.habraReserva,
    );
  }
  //Pedir reservas en el mismo dia
  if (j == diaActual && !reservado) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.consulta,
    );
  }
  //Una reserva vieja en la semana
  if (j < diaActual && !reservado) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.concluido,
    );
  }

  //Se bloquea el reservas para dia que estan mas de 2 dias alejas del dia actual
  if (j >= diaActual + 2 && !reservado) {
    estampilla = const EstampillasReservas(
      estampilla: Estampillas.bloqueado,
    );
  }

  return estampilla;
}
