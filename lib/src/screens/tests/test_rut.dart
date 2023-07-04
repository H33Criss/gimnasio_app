import 'package:flutter/material.dart';

class TestRut extends StatefulWidget {
  const TestRut({super.key});

  @override
  State<TestRut> createState() => _TestRutState();
}

class _TestRutState extends State<TestRut> {
  @override
  Widget build(BuildContext context) {
    TextEditingController rutController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Rut'),
      ),
      body: Column(
        children: [
          TextField(
            controller: rutController,
          ),
          ElevatedButton(onPressed: () {}, child: Text('Comprobar'))
        ],
      ),
    );
  }
}

bool checkRut(input) {
  bool checked = false;
  bool rutValidator(String rut) {
    int rutBody;
    String dv;
    int M = 0;
    int S = 1;
    if (rut.contains('-')) {
      var splitRut = rut.split('-');
      rutBody = int.parse(splitRut[0].replaceAll('.', ''));
      dv = splitRut[1];
    } else {
      rutBody = int.parse(rut.substring(0, rut.length - 1));
      dv = rut.substring(rut.length - 1);
    }
    for (; rutBody != 0; rutBody ~/= 10)
      S = (S + rutBody % 10 * (9 - M++ % 6)) % 11;
    String checkChar = (S > 0) ? '${S - 1}' : 'k';
    return dv.toLowerCase() == checkChar;
  }

  RegExp rut = new RegExp(r'^(\d{1,3}(?:.\d{1,3}){2}-[\dkK])$');
  String input = "20.482.871-7";

  if (rut.hasMatch(input)) {
    if (rutValidator(input)) {
      print('ES VALIDO');
      checked = true;
    } else {
      print('ES INVALIDO, CORRIGA DIGITO VERIFICADOR');
    }
  } else {
    print('ES INVALIDA LA ESTRUCTURA.');
  }

  return checked;
}
