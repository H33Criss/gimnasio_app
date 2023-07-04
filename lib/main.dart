import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/config/firebase/firebase_app.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:provider/provider.dart';
import 'config/router/app_router.dart';
import 'config/themes/main_theme.dart';

FirebaseService firebaseService = FirebaseService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseService.setFirebaseApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReservaProvider()..initCalcDiasSemana(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Gimansio USM JMC',
        routerConfig: appRouter,
        theme: MainTheme(selectedColor: 5).getTheme(false),
      ),
    );
  }
}
