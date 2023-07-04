import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_app/config/menu/menu_items_home.dart';
import 'package:gym_app/src/screens/home/widgets/menu_desplegable.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.home_filled,
          color: colors.primary,
        ),
        actions: const [
          MenuDesplegable(),
          SizedBox(width: 10),
        ],
        title: const Text('Inicio'),
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            splashColor: colors.primary.withOpacity(0.35),
            title: Text(
              item.title,
              style: textStyles.bodyLarge,
            ),
            subtitle: Text(item.subTitle),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: colors.primary,
            ),
            leading: Icon(
              item.icon,
              color: colors.primary,
            ),
            // ignore: avoid_print
            onTap: () => context.push(item.link),
          );
        },
      ),
    );
  }
}
