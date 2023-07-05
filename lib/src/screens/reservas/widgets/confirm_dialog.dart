import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_app/config/helpers/format_fechas.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/qr/widgets/text_pair.dart';
import 'package:gym_app/src/shared/data/semana_data.dart';
import 'package:provider/provider.dart';

class ConfirmDialog extends StatefulWidget {
  final int fila;
  final int columna;
  final List<DateTime> fechas;
  const ConfirmDialog(
      {super.key,
      required this.fila,
      required this.fechas,
      required this.columna});

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  String? tipoDeEntrenamiento;
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    final horario = hours[widget.fila];
    final fecha = FormatsFechas.dateToString(widget.fechas[widget.columna]);
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final userProvider = context.watch<UserProvider>();
    final reservaProvider = context.watch<ReservaProvider>();
    return AlertDialog(
      title: const Text('Confirma tu reserva'),
      content: SizedBox(
        height: size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  const TextSpan(text: 'Estimado '),
                  TextSpan(
                      text: '${userProvider.user?.displayName}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ', ¿Esta correcta su reserva?'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextPair(title: 'Bloque: ', content: horario.bloque.toString()),
            TextPair(title: 'Entrada: ', content: horario.entrada),
            TextPair(title: 'Salida: ', content: horario.salida),
            TextPair(title: 'Fecha: ', content: fecha),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                errorText: clicked && tipoDeEntrenamiento == null
                    ? 'Debe seleccionar un motivo'
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: const OutlineInputBorder(),
                label: const Text('Motivo'),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
              hint: const Text('Seleccione una opción'),
              value: tipoDeEntrenamiento,
              onChanged: (String? newValue) {
                setState(() {
                  tipoDeEntrenamiento = newValue;
                });
              },
              items: <String>[
                'Recuperativa',
                'Clases Grupales',
                'Entrenamiento'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor seleccione una opción';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () async {
            if (tipoDeEntrenamiento != null && !reservaProvider.loading) {
              DateTime now = DateTime.now();
              final horario = hours[widget.fila];
              reservaProvider.toggleLoad();
              final newReserva = ReservaModel(
                bloque: horario.bloque,
                confirmada: false,
                dia: widget.columna,
                entrada: horario.entrada,
                salida: horario.entrada,
                uid: userProvider.user!.uid,
                motivo: tipoDeEntrenamiento!,
                fecha: reservaProvider.diasSemanaFechaCompleta[widget.columna],
                createdAt: now,
              );
              await reservaProvider.createNewReserva(newReserva).then((value) {
                reservaProvider.toggleLoad();
                context.pop();
              });
            }
            setState(() => clicked = true);
          },
          child: reservaProvider.loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : const Text('Aceptar'),
        )
      ],
    );
  }
}
