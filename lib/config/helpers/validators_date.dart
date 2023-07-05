import 'package:gym_app/infrastructure/models/reservas_model.dart';

class ResposeCheckIfExistsReserva {
  ReservaModel? reserva;
  bool existsReserva;

  ResposeCheckIfExistsReserva({
    required this.existsReserva,
    this.reserva,
  });
}

ResposeCheckIfExistsReserva checkIfExistAnyReserva(
    List<ReservaModel> reservas, int fila, int columna) {
  bool existReservaHere = false;
  ReservaModel? reserva;
  reservas.forEach((r) {
    if (r.bloque == fila && r.dia == columna) {
      existReservaHere = true;
      reserva = r;
    }
  });
  return ResposeCheckIfExistsReserva(
    reserva: reserva,
    existsReserva: existReservaHere,
  );
}
