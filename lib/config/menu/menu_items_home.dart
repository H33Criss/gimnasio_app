import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
  });
}

const List<MenuItem> menuItems = [
  MenuItem(
    title: 'Mi perfil',
    subTitle: 'Configura tus datos personales',
    link: '/profile',
    icon: Icons.person_pin_sharp,
  ),
  MenuItem(
    title: 'Reservar Hora',
    subTitle: 'Encuentra horas disponibles para entrar al Gym',
    link: '/reserve',
    icon: Icons.calendar_month_outlined,
  ),
  MenuItem(
    title: 'Escanear Qr',
    subTitle: 'Escanea un Qr para verificar hora de reservación',
    link: '/scan',
    icon: Icons.qr_code_scanner_rounded,
  ),
  MenuItem(
    title: 'Mis horas',
    subTitle: 'Mostrar mis horas generadas',
    link: '/horas',
    icon: Icons.calendar_today,
  ),
  // MenuItem(
  //   title: 'Test',
  //   subTitle: 'Tests',
  //   link: '/test',
  //   icon: Icons.local_bar_sharp,
  // ),
];
