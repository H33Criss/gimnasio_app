import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/reservas/widgets/texto_rico.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  ReservaProvider reservaProvider = ReservaProvider();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool showed = false;
  late String dia;
  late String horaEntrada;
  late String horaSalida;
  late int bloque;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.primary,
        foregroundColor: colors.surface,
        onPressed: () => context.pop(),
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: SizedBox(
        child: _buildQrView(context),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    scanArea = scanArea * 2;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(
    QRViewController controller,
  ) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        result = scanData;

        if (result != Barcode("", BarcodeFormat.aztec, []) && !showed) {
          showed == true;
          controller.pauseCamera();
          ReservaModel data = await reservaProvider
              .setConfirmarReservar(result!.code as String);

          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Escaneado correctamente'),
                    content: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Center(
                              child: Text(
                            data.nameOfUser != null
                                ? data.nameOfUser!
                                : 'No se econtró alumno',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                          const Divider(),
                          TextoRico(nombre: 'Hora Inicio', valor: data.entrada),
                          TextoRico(nombre: 'Hora Termino', valor: data.salida),
                          TextoRico(
                              nombre: 'Bloque', valor: data.bloque.toString()),
                          Text(
                            data.confirmadaToString(),
                            style: const TextStyle(color: Colors.green),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 25),
                            height: 200,
                            width: 200,
                            child: Center(
                              child: Image.asset(
                                'assets/images/check2.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('CERRAR'),
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                          controller.resumeCamera();
                        },
                      )
                    ],
                  ));
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
