import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyReservas extends StatelessWidget {
  const EmptyReservas({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    return Column(
      children: [
        Center(
            child: Image.asset(
          'assets/images/empty.png',
          width: size.width * 0.8,
          height: size.height * 0.3,
          fit: BoxFit.contain,
        )),
        const SizedBox(height: 20),
        SizedBox(
          width: size.width * 0.68,
          child: Text(
            'Aun no haz hecho reservas, vuelve aqui cuando hayas reservado.',
            style: textStyles.bodyLarge,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: FilledButton.icon(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(
                  vertical: size.height * 0.010,
                  horizontal: size.width * .2,
                ),
              ),
            ),
            onPressed: () async {
              context.push('/reserve');
            },
            icon: const Text('Ir a reservar'),
            label: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
      ],
    );
  }
}
