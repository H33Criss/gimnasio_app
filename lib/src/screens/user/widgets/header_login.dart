import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            height: size.height * 0.295,
            width: size.width,
            color: colors.primary.withOpacity(.5),
          ),
        ),
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            height: size.height * 0.28,
            width: size.width,
            color: colors.primary,
          ),
        ),
        //*********Header *********/
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: size.width * 0.85,
              height: size.height * 0.15,
              // color: Colors.green,
              child: Column(
                children: [
                  Text(
                    'Gimnasio USM JMC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textStyle.headlineLarge?.fontSize,
                    ),
                  ),
                  Text(
                    'Ingreso de sesión.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textStyle.bodyLarge?.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
