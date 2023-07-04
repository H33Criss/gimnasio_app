import 'package:flutter/material.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final reservaProvider = context.watch<ReservaProvider>();
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tests'),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: reservaProvider.getListOfReservas(userProvider.user!.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) const CircularProgressIndicator();
              List<ReservaModel> reservas = snapshot.data ?? [];
              return Container(
                color: Colors.blue,
                child: Column(
                  children: reservas.map((e) {
                    return Container(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Text(e.bloque.toString()),
                          Text(e.dia),
                          Text(e.entrada),
                          Text(e.salida),
                          Text(e.confirmada ? 'Confirmada' : 'Por Confirmar'),
                          Text(e.idDoc!),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          FilledButton(
            child: const Text('Actualizar'),
            onPressed: () async {
              final reserva = await reservaProvider
                  .setConfirmarReservar('GvjZ7fOX1bCs6Vq6jAnF');
            },
          ),
          FilledButton(
            child: const Text('Crear reserva'),
            onPressed: () async {
              DateTime now = DateTime.now();
              //Añadir dias
              final newReserva = ReservaModel(
                bloque: 1,
                confirmada: false,
                dia: 'Miercoles',
                entrada: '9:35',
                salida: '10:45',
                uid: userProvider.user!.uid,
                motivo: 'Recuperativo',
                fecha: '11/11/1111',
                createdAt: now,
              );
              await reservaProvider.createNewReserva(newReserva);
            },
          ),
        ],
      ),
    );
  }
}
