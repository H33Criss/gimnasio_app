import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/user/widgets/body_profile.dart';
import 'package:gym_app/src/screens/user/widgets/header_profile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController rutCtrl;
  late TextEditingController carreraCtrl;
  final formKeyProfile = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final userProvider = context.read<UserProvider>();
    rutCtrl = TextEditingController(text: userProvider.user?.rut ?? '');
    carreraCtrl = TextEditingController(text: userProvider.user?.carrera ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Test',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: colors.primary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.primary,
        foregroundColor: colors.surface,
        onPressed: () => context.pop(),
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      body: Column(
        children: [
          const HeaderProfile(),
          BodyProfile(
            formKeyProfile: formKeyProfile,
            controllers: [
              rutCtrl,
              carreraCtrl,
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: size.height * 0.021, left: 30),
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilledButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(
                            vertical: size.height * 0.018,
                            horizontal: size.width * .2),
                      ),
                    ),
                    onPressed: () async {
                      if (userProvider.uiStatus != UiStatus.loading) {
                        await userProvider
                            .setUserProfile(
                          rutCtrl.text,
                          carreraCtrl.text,
                        )
                            .then((value) {
                          _openCustomDialog(context);
                        });
                      }
                    },
                    label: userProvider.uiStatus == UiStatus.loading
                        ? const Text('')
                        : const Icon(Icons.wifi_protected_setup_outlined),
                    icon: userProvider.uiStatus == UiStatus.loading
                        ? const CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          )
                        : const Text(
                            'Guardar',
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 3,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _openCustomDialog(BuildContext context) {
  final textStyles = Theme.of(context).textTheme;
  Size size = MediaQuery.of(context).size;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      title: Center(
        child: Text(
          'Perfil actualizado correctamente',
          style: textStyles.titleMedium,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/check2.png',
            width: size.width * 0.5,
            height: size.width * 0.5,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text:
                    'Ahora ya dispones de todos los requisitos para realizar reservas.',
                style: textStyles.titleSmall,
              ),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
      actions: [
        Center(
          child: FilledButton(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(
                    vertical: size.height * 0.012,
                    horizontal: size.width * .25),
              ),
            ),
            onPressed: () => context.pop(),
            child: const Text('Aceptar'),
          ),
        )
      ],
    ),
  );
}
