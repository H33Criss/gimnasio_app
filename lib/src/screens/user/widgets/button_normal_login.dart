import 'package:flutter/material.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:provider/provider.dart';

class ButtonNormalLogin extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> controllers;
  const ButtonNormalLogin(
      {super.key, required this.formKey, required this.controllers});

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
          final email = controllers[0].text;
          final password = controllers[1].text;
          if (formKey.currentState!.validate() &&
              userProvider.status.value != AuthStatus.authenticating) {
            await userProvider.loginWithEmailAndPassword(email, password);
          }
        },
        label: userProvider.status.value == AuthStatus.authenticating
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.keyboard_arrow_right_outlined),
        icon: userProvider.status.value == AuthStatus.authenticating
            ? Container()
            : const Text('Ingreso administrador'),
      ),
    );
  }
}
