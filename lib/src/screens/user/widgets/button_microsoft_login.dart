import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_app/src/providers/providers.dart';

class ButtonMicrosoftLogin extends StatelessWidget {
  const ButtonMicrosoftLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      child: FilledButton.icon(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(vertical: size.height * 0.025),
          ),
        ),
        onPressed: () async {
          await userProvider.loginWithMicrosoft();
        },
        label: userProvider.status.value == AuthStatus.authenticating
            ? Container()
            : const Text('Ingreso para Alumnos/Profesores'),
        icon: Image.asset(
          'assets/images/microsoft.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
