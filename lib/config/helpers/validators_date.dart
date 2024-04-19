import 'package:gym_app/infrastructure/models/reservas_model.dart';

class ResposeCheckIfExistsReserva {
  ReservaModel? reserva;
  bool existsReserva;
  bool existReservaPerDay;

  ResposeCheckIfExistsReserva({
    required this.existsReserva,
    required this.existReservaPerDay,
    this.reserva,
  });
}

ResposeCheckIfExistsReserva checkIfExistAnyReserva(
    List<ReservaModel> reservas, int fila, int columna) {
  bool existReservaHere = false;
  bool existReservaPerDay = false;
  ReservaModel? reserva;
  DateTime now = DateTime.now();

  // DateTime primerDiaDeLaSemana = ahora.subtract(Duration(days: (ahora.weekday - 1)));
  reservas.forEach((r) {
    if (r.bloque == fila &&
        r.dia == columna &&
        r.mes == now.month &&
        r.anio == now.year) {
      existReservaHere = true;
      reserva = r;
    }
    if (r.dia == columna && r.mes == now.month && r.anio == now.year) {
      existReservaPerDay = true;
    }
  });
  return ResposeCheckIfExistsReserva(
    reserva: reserva,
    existsReserva: existReservaHere,
    existReservaPerDay: existReservaPerDay,
  );
}
