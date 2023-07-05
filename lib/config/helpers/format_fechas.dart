import 'package:intl/intl.dart';

class FormatsFechas {
  static String dateToString(DateTime fecha) {
    String fechaFormateada = DateFormat('d MMMM yyyy', 'es_ES').format(fecha);
    return fechaFormateada;
  }
}
