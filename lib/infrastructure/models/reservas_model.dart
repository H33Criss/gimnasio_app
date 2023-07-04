// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReservaModel {
  String? idDoc;
  int bloque;
  bool confirmada;
  String dia;
  String entrada;
  String salida;
  String uid;
  String motivo;
  String? nameOfUser;
  String fecha;
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
      fecha: reserva['fecha'],
      createdAt: (reserva['createdAt'] as Timestamp).toDate(),
    );
  }

  void confirmarReserva() {
    if (!confirmada) {
      confirmada = true;
    }
  }

  String confirmadaToString() {
    return confirmada ? 'Confirmada' : 'Por confirmar';
  }
}
