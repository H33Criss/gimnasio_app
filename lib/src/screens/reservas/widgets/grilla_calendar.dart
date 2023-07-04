import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/config/helpers/validators_date.dart';
import 'package:gym_app/src/screens/reservas/widgets/dialog_reservation.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';

class GrillaCalendar extends StatefulWidget {
  final double heightGrilla;
  final double widthGrilla;
  const GrillaCalendar({
    super.key,
    required this.heightGrilla,
    required this.widthGrilla,
  });

  @override
  State<GrillaCalendar> createState() => _GrillaCalendarState();
}

class _GrillaCalendarState extends State<GrillaCalendar> {
  @override
  Widget build(BuildContext context) {
    final reservaProvider = context.watch<ReservaProvider>();
    final userProvider = context.watch<UserProvider>();
    List<int> columnas = List<int>.generate(7, (index) => index);
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    List<String> accessReservation = getValidatorReservation();
    return StreamBuilder(
      stream: reservaProvider.getListOfReservas(userProvider.user!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {}
        List<ReservaModel> reservas = snapshot.data ?? [];
        return reservas.isEmpty
            ? Column(
                children: columnas.map((j) {
                  List<int> filas = List<int>.generate(5, (index) => index);
                  return Row(
                    children: filas.map((i) {
                      String diaReserva = processDay(i);
                      diaReserva = deletAccent(diaReserva);
                      return InkWell(
                        splashColor: colors.primary.withOpacity(.1),
                        hoverColor: colors.primary.withOpacity(.1),
                        onTap: () {
                          if (accessReservation[1] == diaReserva) {
                            i = i + 1;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogReservation(
                                    bloque: j,
                                    dia: i,
                                    acceso: 'Autorizado',
                                    idReserva: 'hola');
                              },
                              barrierDismissible: false,
                            );
                            i = i - 1;
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DialogReservation(
                                    bloque: j,
                                    dia: i,
                                    acceso: 'Denegado',
                                    idReserva: 'hola');
                              },
                              barrierDismissible: false,
                            );
                          }
                        },
                        child: Container(
                          width: size.width * 0.85 / 5,
                          height: widget.heightGrilla,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: colors.primary,
                              width: .3,
                            ),
                            color: accessReservation[1] != diaReserva
                                ? Colors.blueGrey.withOpacity(.2)
                                : Colors.transparent,
                          ),
                          child: accessReservation[1] != diaReserva
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    accessReservation[0] == diaReserva
                                        ? Column(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.circleQuestion,
                                                color: colors.primary,
                                              ),
                                              Text(
                                                'Consultar',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: colors.primary,
                                                ),
                                              ),
                                            ],
                                          )
                                        : reservaProvider.diaActual <
                                                reservaProvider
                                                    .diasSemanaSoloNumero[i]
                                            ? Column(
                                                children: [
                                                  Icon(
                                                      Icons.lock_clock_outlined,
                                                      color: colors.primary),
                                                  Text(
                                                    'Bloqueado',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: colors.primary,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  const Icon(Icons.lock,
                                                      color: Colors.grey),
                                                  Text(
                                                    'Concluido',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.black
                                                          .withOpacity(.5),
                                                    ),
                                                  ),
                                                ],
                                              )
                                  ],
                                )
                              : const SizedBox(),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              )
            : Column(
                children: reservas.map((e) {
                  String idReserva = e.idDoc!;
                  int bloqueFinal = e.bloque - 1;
                  String diaS = e.dia;
                  int diaFinal = processDayLetra(diaS);
                  return Column(
                    children: columnas.map((j) {
                      List<int> filas = List<int>.generate(5, (index) => index);
                      return Row(
                        children: filas.map((i) {
                          String diaReserva = processDay(i);
                          diaReserva = deletAccent(diaReserva);
                          return InkWell(
                            splashColor: colors.primary.withOpacity(.1),
                            hoverColor: colors.primary.withOpacity(.1),
                            onTap: () {
                              if (accessReservation[1] == diaReserva) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogReservation(
                                        bloque: j,
                                        dia: i,
                                        acceso: 'Reservado',
                                        idReserva: idReserva);
                                  },
                                  barrierDismissible: false,
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogReservation(
                                        bloque: j,
                                        dia: i,
                                        acceso: 'Denegado',
                                        idReserva: idReserva);
                                  },
                                  barrierDismissible: false,
                                );
                              }
                            },
                            onLongPress: () {
                              bloqueFinal == j && diaFinal == i
                                  ? showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogReservation(
                                            bloque: j,
                                            dia: i,
                                            acceso: 'Eliminando',
                                            idReserva: idReserva);
                                      },
                                      barrierDismissible: false,
                                    )
                                  : null;
                            },
                            child: Container(
                              width: size.width * 0.85 / 5,
                              height: widget.heightGrilla,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colors.primary,
                                  width: .3,
                                ),
                                color: accessReservation[1] != diaReserva
                                    ? accessReservation[0] == diaReserva
                                        ? Colors.blueGrey.withOpacity(.1)
                                        : reservaProvider.diaActual <
                                                reservaProvider
                                                    .diasSemanaSoloNumero[i]
                                            ? Colors.blueGrey.withOpacity(.2)
                                            : Colors.black.withOpacity(.1)
                                    : Colors.transparent,
                              ),
                              child: accessReservation[1] != diaReserva
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        accessReservation[0] == diaReserva
                                            ? Column(
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons
                                                        .circleQuestion,
                                                    color: colors.primary,
                                                  ),
                                                  Text(
                                                    'Consultar',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: colors.primary,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : reservaProvider.diaActual <
                                                    reservaProvider
                                                        .diasSemanaSoloNumero[i]
                                                ? Column(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .lock_clock_outlined,
                                                          color:
                                                              colors.primary),
                                                      Text(
                                                        'Bloqueado',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: colors.primary,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      const Icon(Icons.lock,
                                                          color: Colors.grey),
                                                      Text(
                                                        'Concluido',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black
                                                              .withOpacity(.5),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                      ],
                                    )
                                  : reservas.isEmpty
                                      ? const SizedBox()
                                      : bloqueFinal == j && diaFinal == i
                                          ? const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.circleCheck,
                                                  color: Colors.green,
                                                ),
                                                Text(
                                                  'Reservado',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : reservas.isNotEmpty
                                              ? const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.slash,
                                                      color: Colors.grey,
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  );
                }).toList(),
              );
      },
    );
  }
}
