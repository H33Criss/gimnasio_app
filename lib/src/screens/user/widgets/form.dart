import 'package:flutter/material.dart';
import 'package:gym_app/config/helpers/validators_form.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/user/widgets/input_form.dart';
import 'package:provider/provider.dart';

class FormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> controllers;

  const FormWidget(
      {super.key, required this.formKey, required this.controllers});
  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailCtrl = widget.controllers[0];
    TextEditingController passwordCtrl = widget.controllers[1];
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final isDarkMode = Brightness.dark == Theme.of(context).brightness;
    final userProvider = context.watch<UserProvider>();

    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: size.height * 0.03, horizontal: 30),
          margin:
              const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
          width: size.width,
          height: size.height * 0.38,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color.fromARGB(255, 21, 21, 21)
                : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? const Color.fromARGB(255, 184, 183, 183).withOpacity(0.2)
                    : const Color.fromARGB(255, 39, 38, 38).withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 20,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Inicio de sesión',
                          style: textStyle.titleLarge,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              InputForm(
                  text: 'Correo electronico',
                  controller: emailCtrl,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Indique su email';
                    }
                    if (ValidatorsForm.isValidEmail(value)) {
                      return null;
                    } else {
                      return 'Ingrese un formato de email valido';
                    }
                  }),
              const SizedBox(height: 25),
              InputForm(
                passObscure: true,
                enableEyeMode: true,
                text: 'Contraseña',
                controller: passwordCtrl,
                validator: (value) {
                  if (ValidatorsForm.isPasswordDefined(value!)) {
                    return 'Debes ingresar una contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              Column(
                children: userProvider.errors.map((error) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: colors.error,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: colors.error),
                      ),
                    ],
                  );
                }).toList(),
              ),
              // const Spacer(),
              InkWell(
                onTap: () {},
                child: Center(
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      color: colors.surfaceTint,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
