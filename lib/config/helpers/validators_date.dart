import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:gym_app/src/shared/data/semana_data.dart';
import 'package:string_normalizer/string_normalizer.dart';

List<dynamic> getDateWeek(int validator) {
  initializeDateFormatting('es', null);
  DateTime fechaActual = DateTime.now();
  String fechaDiaFormateada = DateFormat('EEEE', 'es').format(fechaActual);
  fechaDiaFormateada =
      fechaDiaFormateada[0].toUpperCase() + fechaDiaFormateada.substring(1);
  int diaFix = int.parse(DateFormat('dd', 'es').format(fechaActual));
  String fechaMesFormateado = DateFormat('MMMM', 'es').format(fechaActual);

  List<dynamic> formatoSuma = [];

  switch (fechaDiaFormateada) {
    case 'Lunes':
      formatoSuma = [0, 1, 2, 3, 4, 5, 6];
      break;
    case 'Martes':
      formatoSuma = [-1, 0, 1, 2, 3, 4, 5];
      break;
    case 'Miércoles':
      formatoSuma = [-2, -1, 0, 1, 2, 3, 4];
      break;
    case 'Jueves':
      formatoSuma = [-3, -2, -1, 0, 1, 2, 3];
      break;
    case 'Viernes':
      formatoSuma = [-4, -3, -2, -1, 0, 1, 2];
      break;
    case 'Sábado':
      formatoSuma = [-5, -4, -3, -2, -1, 0, 1];
      break;
    case 'Domingo':
      formatoSuma = [1, 2, 3, 4, 5, 6, 0];
      break;
  }

  // el resultado: formatoSuma=[-5, -4, -3, -2, -1, 0, 1]

  List<dynamic> diaSemana = [
    ['Lu'],
    ['Ma'],
    ['Mi'],
    ['Ju'],
    ['Vi'],
    ['Sa'],
    ['Do']
  ];
  for (int i = 0; i < diaSemana.length; i++) {
    diaSemana[i].add((formatoSuma[i] + diaFix).toString());
  }
  // el resultado: diaSemana =[[Lu, 12]u, 1, [Ma, 13], [Mi, 14], [J5], [Vi, 16], [Sa, 17], [Do, 18]]

  if (validator == 1) {
    for (int i = 0; i < diaSemana.length; i++) {
      diaSemana[i][1] = "${diaSemana[i][1]} $fechaMesFormateado";
    }
    //el resultado: diaSemana =[[Lu, 12 junio], [Ma, 13 junio], [Mi, 14 junio], [Ju, 15 junio], [Vi, 16 junio], [Sa, 17 junio], [Do, 18 junio]]
  }

  return diaSemana;
}

String processDay(int dia) {
  String diaFinal = '';

  switch (dia) {
    case 0:
      diaFinal = 'Lunes';
      break;
    case 1:
      diaFinal = 'Martes';
      break;
    case 2:
      diaFinal = 'Miercoles';
      break;
    case 3:
      diaFinal = 'Jueves';
      break;
    case 4:
      diaFinal = 'Viernes';
      break;
    case 5:
      diaFinal = 'Sabado';
      break;
    case 6:
      diaFinal = 'Domingo';
      break;
  }
  return diaFinal;
}

int processDayLetra(String dia) {
  int diaFinal = 0;

  switch (dia) {
    case 'Lunes':
      diaFinal = 0;
      break;
    case 'Martes':
      diaFinal = 1;
      break;
    case 'Miercoles':
      diaFinal = 2;
      break;
    case 'Jueves':
      diaFinal = 3;
      break;
    case 'Viernes':
      diaFinal = 4;
      break;
    case 'Sabado':
      diaFinal = 5;
      break;
    case 'Domingo':
      diaFinal = 6;
      break;
  }
  return diaFinal;
}

List<dynamic>? getHour(int bloques) {
  List<dynamic>? entradaSalida = [];
  hours.map((hour) {
    if (hour['bloque'] == bloques + 1) {
      String entrada = hour['entrada'];
      String salida = hour['salida'];
      entradaSalida = [entrada, salida];
    }
  }).toList();

  // el resultado es: entradaSalida = [09:35 AM, 10:45 AM]
  return entradaSalida;
}

List<String> getValidatorReservation() {
  initializeDateFormatting('es', null);
  DateTime fechaActual = DateTime.now();
  String fechaDiaFormateada = DateFormat('EEEE', 'es').format(fechaActual);
  fechaDiaFormateada =
      fechaDiaFormateada[0].toUpperCase() + fechaDiaFormateada.substring(1);

  fechaDiaFormateada = StringNormalizer.normalize(fechaDiaFormateada);
  List<String> accessReservation = [];

  validatorReservation.map((days) {
    if (days['diaActual'] == fechaDiaFormateada) {
      final String diaActual = days['diaActual'];
      final String diaReserva = days['diaReserva'];
      accessReservation = [diaActual, diaReserva];
    }
  }).toList();

  //El resultado es: accessReservation = [Sabado, Domingo]
  return accessReservation;
}

String deletAccent(String fechaDiaFormateada) {
  fechaDiaFormateada = StringNormalizer.normalize(fechaDiaFormateada);
  return fechaDiaFormateada;
}

String? getDate(String tipo) {
  initializeDateFormatting('es', null);
  DateTime fechaActual = DateTime.now();
  String fechaCompletaFormateada =
      DateFormat('dd MMMM yyyy', 'es').format(fechaActual);
  String fechaMesFormateada = DateFormat('MMMM', 'es').format(fechaActual);
  String fechaDiaFormateada = DateFormat('EEEE', 'es').format(fechaActual);
  fechaDiaFormateada =
      fechaDiaFormateada[0].toUpperCase() + fechaDiaFormateada.substring(1);

  if (tipo == 'dia') {
    return fechaDiaFormateada;
  } else {
    if (tipo == 'mes') {
      return fechaMesFormateada;
    } else {
      if (tipo == 'completo') {
        return fechaCompletaFormateada;
      }
    }
  }
  //El resultado es: fechaCompletaFormateada =
  return null;
}

String dateReservation(String diaReservaTest) {
  int validator = 1;
  List<dynamic> diasSemanas = getDateWeek(validator);
  String fechaReserva = '';
  for (int i = 0; i < diasSemanas.length; i++) {
    if (diasSemanas[i][0] == diaReservaTest) {
      fechaReserva = diasSemanas[i][1];
      break;
    }
  }
  return fechaReserva;
}
