import 'package:flutter/material.dart';

class TextoRico extends StatelessWidget {
  final String nombre;
  final String valor;

  TextoRico({required this.nombre, required this.valor});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$nombre: ',
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: valor,
            style: DefaultTextStyle.of(context).style,
          ),
        ],
      ),
    );
  }
}
