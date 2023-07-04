import 'package:flutter/material.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/user/widgets/input_form.dart';
import 'package:provider/provider.dart';

class BodyProfile extends StatefulWidget {
  final GlobalKey<FormState> formKeyProfile;
  final List<TextEditingController> controllers;

  const BodyProfile(
      {super.key, required this.controllers, required this.formKeyProfile});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  @override
  Widget build(BuildContext context) {
    TextEditingController rutCtrl = widget.controllers[0];
    TextEditingController carreraCtrl = widget.controllers[1];
    Size size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final userProvider = context.watch<UserProvider>();
    final colors = Theme.of(context).colorScheme;
    return Form(
        key: widget.formKeyProfile,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    'Tus datos personales',
                    style: textStyles.headlineSmall,
                  ),
                  const SizedBox(width: 10),
                  userProvider.user?.rut != null &&
                          userProvider.user?.carrera != null
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: colors.primary,
                        )
                      : const Icon(Icons.help_outline_rounded,
                          color: Color.fromARGB(255, 249, 163, 33))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: size.width * 0.9,
              child: InputForm(
                text: 'Rut',
                controller: rutCtrl,
                helperText: userProvider.user?.rut != null
                    ? null
                    : 'Debes definir tu Rut para hacer reservas.',
                helperStyle: const TextStyle(
                  color: Colors.red, // Cambia esto al color que prefieras
                ),
                prefixIcon: userProvider.user?.rut != null
                    ? Icon(
                        Icons
                            .check_circle_outline, // Cambia esto al ícono que prefieras
                        color: colors
                            .primary, // Cambia esto al color que prefieras
                      )
                    : const Icon(
                        Icons.help, // Cambia esto al ícono que prefieras
                        color: Colors.red, // Cambia esto al color que prefieras
                      ),
                labelMode: FloatingLabelBehavior.always,
                placeholder: 'ej: xx xxx xxx x',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: size.width * 0.9,
              child: InputForm(
                text: 'Carrera',
                controller: carreraCtrl,
                helperText: userProvider.user?.carrera != null
                    ? null
                    : 'Debes definir tu Carrera para hacer reservas.',
                helperStyle: const TextStyle(
                  color: Colors.red, // Cambia esto al color que prefieras
                ),
                prefixIcon: userProvider.user?.carrera != null
                    ? Icon(
                        Icons
                            .check_circle_outline, // Cambia esto al ícono que prefieras
                        color: colors
                            .primary, // Cambia esto al color que prefieras
                      )
                    : const Icon(
                        Icons.help, // Cambia esto al ícono que prefieras
                        color: Colors.red, // Cambia esto al color que prefieras
                      ),
                labelMode: FloatingLabelBehavior.always,
                placeholder: 'Ingresa tu carrera',
              ),
            ),
          ],
        ));
  }
}
