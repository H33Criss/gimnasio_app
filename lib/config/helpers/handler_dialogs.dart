import 'package:gym_app/config/helpers/custom_dialogs.dart';
import 'package:gym_app/src/screens/reservas/widgets/estampillas_reservas.dart';

Function handleDialog(Estampillas dialogType) {
  switch (dialogType) {
    case Estampillas.bloqueado:
      return bloqueadoDialog;
    case Estampillas.huboReserva:
      return huboReservaDialog;
    case Estampillas.habraReserva:
      return habraReservaDialog;
    case Estampillas.concluido:
      return concluidoDialog;
    case Estampillas.consulta:
      return consultaDialog;
    case Estampillas.onePerDay:
      return onePerDayDialog;

    default:
      return reservadoDialog;
  }
}
