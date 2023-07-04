import 'package:flutter/material.dart';
import 'package:gym_app/src/screens/user/widgets/button_footer.dart';
import 'package:gym_app/src/screens/user/widgets/form.dart';
import 'package:gym_app/src/screens/user/widgets/header_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailCtrl = TextEditingController();
    TextEditingController passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: ListView(
        children: [
          const HeaderLogin(),
          FormWidget(
            formKey: formKey,
            controllers: [emailCtrl, passwordCtrl],
          ),
          const SizedBox(height: 20),
          ButtonFooter(
            formKey: formKey,
            controllers: [emailCtrl, passwordCtrl],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
