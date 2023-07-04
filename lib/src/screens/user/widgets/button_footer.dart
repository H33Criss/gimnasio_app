import 'package:flutter/material.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/user/widgets/button_microsoft_login.dart';
import 'package:gym_app/src/screens/user/widgets/button_normal_login.dart';
import 'package:provider/provider.dart';

class ButtonFooter extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> controllers;
  const ButtonFooter(
      {super.key, required this.formKey, required this.controllers});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final colors = Theme.of(context).colorScheme;
    return userProvider.status.value == AuthStatus.authenticating
        ? Center(
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: colors.primary,
                  strokeWidth: 3,
                ),
                const SizedBox(height: 10),
                Text(
                  'Verificando...',
                  style: TextStyle(color: colors.primary),
                ),
              ],
            ),
          )
        : Column(
            children: [
              ButtonNormalLogin(
                formKey: formKey,
                controllers: [controllers[0], controllers[1]],
              ),
              const SizedBox(height: 15),
              const ButtonMicrosoftLogin(),
            ],
          );
  }
}
