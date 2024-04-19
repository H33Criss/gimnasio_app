// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_app/src/shared/data/semana_data.dart';

class ReservaModel {
  String? idDoc;
  int bloque;
  bool confirmada;
  int dia;
  String entrada;
  String salida;
  String uid;
  String motivo;
  String? nameOfUser;
  DateTime fecha;
  DateTime createdAt;

  ReservaModel({
    this.idDoc,
    required this.bloque,
    required this.confirmada,
    required this.dia,
    required this.entrada,
    required this.salida,
    required this.uid,
    required this.motivo,
    required this.fecha,
    required this.createdAt,
  });

  factory ReservaModel.fromFirestore(Map<String, dynamic> reserva) {
    return ReservaModel(
      idDoc: reserva['idDoc'],
      bloque: reserva['bloque'],
      confirmada: reserva['confirmada'],
      dia: reserva['dia'],
      entrada: reserva['entrada'],
      salida: reserva['salida'],
      uid: reserva['uid'],
      motivo: reserva['motivo'],
      fecha: (reserva['fecha'] as Timestamp).toDate(),
      createdAt: (reserva['createdAt'] as Timestamp).toDate(),
    );
  }

  void confirmarReserva() {
    if (!confirmada) {
      confirmada = true;
    }
  }

  int get mes {
    return fecha.month;
  }

  int get anio {
    return fecha.year;
  }

  int get numeroDia {
    return fecha.day;
  }

  String confirmadaToString() {
    return confirmada ? 'Confirmada' : 'Por confirmar';
  }

  String diaToString() {
    return nombres[dia];
  }
}
