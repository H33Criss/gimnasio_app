import 'package:flutter/material.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:provider/provider.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final userProvider = context.watch<UserProvider>();

    return CustomPaint(
      painter: _HeaderDiagonalPainter(colors.primary),
      child: ClipPath(
        clipper: _ClipperHexagonal(),
        child: Container(
          color: colors.primary,
          height: size.height * 0.22,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: size.width * 0.04,
                left: size.width * 0.3,
                child: const Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      'Reservas',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.width * 0.04,
                left: size.width * 0.5,
                child: const Column(
                  children: [
                    Text(
                      '1',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      'Faltas',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: size.width * 0.04,
                left: size.width * 0.65,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.009, horizontal: 18),
                      decoration: BoxDecoration(
                          color: colors.onPrimaryContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Activo',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const Text(
                      'Estado para reservar',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: size.width * 0.05,
                child: Container(
                  width: size.width * 0.22,
                  height: size.width * 0.22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset('assets/images/user1.png'),
                ),
              ),
              Positioned(
                bottom: size.width * 0.14,
                left: size.width * 0.12,
                child: Text(
                  userProvider.user!.displayName,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ClipperHexagonal extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height * 0.7);
    path.conicTo(
        size.width * 0.75, size.height, size.width, size.height * 0.7, 20.0);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class _HeaderDiagonalPainter extends CustomPainter {
  final Color color;

  const _HeaderDiagonalPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.style = PaintingStyle.fill;
    final path = Path();

    path.lineTo(0, size.height * 0.7);
    path.conicTo(
        size.width * 0.75, size.height, size.width, size.height * 0.7, 20.0);
    path.lineTo(size.width, 0);
    // canvas.drawPath(path, paint);
    canvas.drawShadow(path, color, 10.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
