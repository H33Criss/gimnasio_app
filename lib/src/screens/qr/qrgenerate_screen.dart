import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/qr/widgets/empty_reservas.dart';
import 'package:gym_app/src/screens/qr/widgets/text_pair.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGenerateScreen extends StatefulWidget {
  const QrGenerateScreen({super.key});

  @override
  State<QrGenerateScreen> createState() => _QrGenerateScreenState();
}

class _QrGenerateScreenState extends State<QrGenerateScreen> {
  @override
  Widget build(BuildContext context) {
    final reservaProvider = context.watch<ReservaProvider>();
    final userProvider = context.watch<UserProvider>();

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Entrada QR',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colors.primary,
          foregroundColor: colors.surface,
          onPressed: () => context.pop(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        body: StreamBuilder(
            stream: reservaProvider.getListOfReservas(userProvider.user!.uid),
            builder: (context, snapshot) {
              if (!snapshot.hasData) const CircularProgressIndicator();

              List<ReservaModel> reservas = snapshot.data ?? [];

              if (reservas.isEmpty &&
                  snapshot.connectionState != ConnectionState.waiting) {
                return const Center(child: EmptyReservas());
              }

              return ListView.separated(
                itemCount: reservas.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final reserva = reservas[index];
                  // modificar here
                  return ListTile(
                    title: Text(
                      reserva.motivo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    hoverColor: colors.primary,
                    splashColor: colors.primary.withOpacity(.3),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Hora Entrada: ${reserva.entrada} -  Bloque: ${reserva.bloque}'),
                        Text('Hora Salida: ${reserva.salida}'),
                      ],
                    ),
                    onTap: () {
                      showItemDetails(context, reserva);
                    },
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 8),
                      decoration: BoxDecoration(
                        color: reserva.confirmada ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        reserva.confirmadaToString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            }));
  }
}

void showItemDetails(BuildContext context, ReservaModel reserva) {
  Size size = MediaQuery.of(context).size;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Detalles de la hora'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: size.width,
                height: size.height * 0.3,
                child: QrImageView(
                  size: size.width,
                  data: reserva.idDoc!,
                ),
              ),
            ),
            TextPair(title: 'Día:', content: reserva.diaToString()),
            TextPair(
                title: 'Motivo:',
                content: reserva.motivo == '' ? 'No definido' : reserva.motivo),
            TextPair(title: 'Bloque:', content: reserva.bloque.toString()),
            TextPair(title: 'Hora entrada:', content: reserva.entrada),
            TextPair(title: 'Hora salida:', content: reserva.salida),
            TextPair(title: 'Estado:', content: reserva.confirmadaToString()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ],
      );
    },
  );
}
