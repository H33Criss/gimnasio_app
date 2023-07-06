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
  reservas.forEach((r) {
    if (r.bloque == fila && r.dia == columna) {
      existReservaHere = true;
      reserva = r;
    }
    if (r.dia == columna) {
      existReservaPerDay = true;
    }
  });
  return ResposeCheckIfExistsReserva(
    reserva: reserva,
    existsReserva: existReservaHere,
    existReservaPerDay: existReservaPerDay,
  );
}
