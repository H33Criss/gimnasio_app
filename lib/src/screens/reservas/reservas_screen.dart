import 'package:flutter/material.dart';
import 'package:gym_app/src/screens/reservas/widgets/body_calendar.dart';
import 'package:gym_app/src/screens/reservas/widgets/header_calendar.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});

  @override
  State<ReservasScreen> createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserva tu Hora'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          HeaderCalendar(),
          Expanded(
            child: BodyCalendar(),
          )
        ],
      ),
    );
  }
}
