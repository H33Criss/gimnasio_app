import 'package:flutter/material.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:provider/provider.dart';

class MenuDesplegable extends StatefulWidget {
  const MenuDesplegable({super.key});

  @override
  State<MenuDesplegable> createState() => _MenuDesplegableState();
}

class _MenuDesplegableState extends State<MenuDesplegable> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final userProvider = context.watch<UserProvider>();
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: colors.primary.withOpacity(.1),
      ),
      child: PopupMenuButton(
        // color: colors.primary,
        tooltip: 'Opciones',
        offset: const Offset(0, 40),
        icon: Row(
          children: [
            Icon(
              Icons.person,
              color: colors.primary,
            ),
            const SizedBox(width: 5),
            Text(userProvider.user?.email ?? 'Error :(',
                style: textStyles.labelMedium)
          ],
        ),
        onSelected: (value) async {
          if (value == 'logout' &&
              userProvider.status.value == AuthStatus.authenticated) {
            await userProvider.signOutUser();
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          const PopupMenuItem(
            value: 'logout',
            child: Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
