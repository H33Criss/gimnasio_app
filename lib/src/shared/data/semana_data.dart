import 'package:flutter/material.dart';
import 'package:gym_app/src/screens/reservas/widgets/estampillas_reservas.dart';

class Hour {
  final String entrada;
  final String salida;
  final int bloque;

  Hour({
    required this.entrada,
    required this.salida,
    required this.bloque,
  });
}

class ResponseHandleEstampilla {
  final Widget estampilla;
  final Estampillas dialog;

  ResponseHandleEstampilla({
    required this.estampilla,
    required this.dialog,
  });
}

final List<String> nombres = [
  'Lunes',
  'Martes',
  'Miercoles',
  'Jueves',
  'Viernes',
  'Sabado',
  'Domingo'
];

List<Hour> hours = [
  Hour(entrada: '09:35 AM', salida: '10:45 AM', bloque: 0),
  Hour(entrada: '10:55 AM', salida: '12:05 AM', bloque: 1),
  Hour(entrada: '12:15 AM', salida: '01:25 PM', bloque: 2),
  Hour(entrada: '02:30 PM', salida: '03:40 PM', bloque: 3),
  Hour(entrada: '03:50 PM', salida: '05:00 PM', bloque: 4),
  Hour(entrada: '05:10 PM', salida: '06:20 PM', bloque: 5),
  Hour(entrada: '06:30 PM', salida: '07:40 PM', bloque: 6),
];
