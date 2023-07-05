import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/infrastructure/repositories/reserva_repository.dart';
import 'package:flutter/foundation.dart';

Future<dynamic> getReserva(String docID, String coleccion) async {
  CollectionReference col = FirebaseFirestore.instance.collection(coleccion);
  DocumentSnapshot snapshot = await col.doc(docID).get();
  var data = snapshot.data() as Map;
  return data;
}

class ReservaProvider extends ChangeNotifier {
  List<int> diasSemanaSoloNumero = [];
  List<DateTime> diasSemanaFechaCompleta = [];
  bool loading = false;
  late int diaActual;
  final ReservaRepository reservaRepository = ReservaRepository();

  void toggleLoad() {
    loading = !loading;
    notifyListeners();
  }

  void initCalcDiasSemana() {
    DateTime ahora = DateTime.now();
    DateTime primerDiaDeLaSemana =
        ahora.subtract(Duration(days: (ahora.weekday - 1)));
    diasSemanaSoloNumero.clear();
    for (int i = 0; i < 7; i++) {
      diasSemanaSoloNumero.add(primerDiaDeLaSemana.add(Duration(days: i)).day);
    }
    notifyListeners();
    getDiaActual();
    getFechasDiasDeLaSemana();
  }

  void getDiaActual() {
    DateTime ahora = DateTime.now();
    diaActual = ahora.day;
    notifyListeners();
  }

  void getFechasDiasDeLaSemana() {
    DateTime ahora = DateTime.now();
    DateTime primerDiaDeLaSemana = DateTime(ahora.year, ahora.month, ahora.day)
        .subtract(Duration(days: (ahora.weekday - 1)));

    for (int i = 0; i < 7; i++) {
      DateTime diaDeLaSemana = primerDiaDeLaSemana.add(Duration(days: i));
      diasSemanaFechaCompleta.add(
          DateTime(diaDeLaSemana.year, diaDeLaSemana.month, diaDeLaSemana.day));
    }
    notifyListeners();
  }

  Stream<List<ReservaModel>> getListOfReservas(String uid) {
    return reservaRepository.getListOfReservas(uid);
  }

  Future<ReservaModel> setConfirmarReservar(String idDoc) async {
    final response = await reservaRepository.setConfirmarReserva(idDoc);
    notifyListeners();
    return response;
  }

  Future<void> deleteReserva(String idDoc) async {
    final response = await reservaRepository.deleteReserva(idDoc);
    print(response);
    notifyListeners();
  }

  Future<void> createNewReserva(ReservaModel newReserva) async {
    final response = await reservaRepository.creteNewReserva(newReserva);
    print(response);
    notifyListeners();
  }
}
