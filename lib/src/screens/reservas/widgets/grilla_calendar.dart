import 'package:flutter/material.dart';
import 'package:gym_app/config/helpers/custom_dialogs.dart';
import 'package:gym_app/config/helpers/handler_dialogs.dart';
import 'package:gym_app/config/helpers/handler_estampillas.dart';
import 'package:gym_app/config/helpers/validators_date.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/providers.dart';
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
                final response = checkIfExistAnyReserva(reservas, i, j);
                final responseEstampilla =
                    handleEstampilla(response.reserva, j, i, reservaProvider);
                final dialog = handleDialog(responseEstampilla.dialog);
                final currentDay = reservaProvider.diasSemanaSoloNumero
                        .indexOf(reservaProvider.diaActual) +
                    1;
                final onePerDay = response.existReservaPerDay &&
                    currentDay == j &&
                    response.reserva?.bloque != i;
                return InkWell(
                  splashColor: colors.primary.withOpacity(.3),
                  onTap: () {
                    if (onePerDay) {
                      onePerDayDialog(context);
                    } else if (!response.existsReserva && currentDay == j) {
                      confirmDialog(
                        context,
                        i,
                        j,
                        reservaProvider.diasSemanaFechaCompleta,
                      );
                    } else {
                      dialog(context);
                    }
                  },
                  onLongPress: () async {
                    if (response.existsReserva && response.reserva != null) {
                      //Este dialog es el unico que recibe 2 parametros extras
                      deleteConfirmDialog(
                          context, reservaProvider, response.reserva!);
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
                    child: onePerDay
                        ? const Icon(
                            Icons.deselect_outlined,
                            color: Colors.grey,
                          )
                        : responseEstampilla.estampilla,
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
