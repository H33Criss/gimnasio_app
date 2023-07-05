import 'package:flutter/material.dart';
import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/shared/data/semana_data.dart';
import 'package:provider/provider.dart';

class HeaderCalendar extends StatelessWidget {
  const HeaderCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final reservaProvider = context.watch<ReservaProvider>();
    return Container(
      width: size.width,
      margin: EdgeInsets.only(left: size.width * 0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: reservaProvider.diasSemanaSoloNumero
            .take(5)
            .toList()
            .asMap()
            .map((i, day) {
              final currentDay = reservaProvider.diaActual;
              return MapEntry(
                  i,
                  Container(
                    height: size.width * 0.24,
                    width: size.width * 0.85 / 5,
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          nombres[i].substring(0, 2),
                          style: TextStyle(
                              color: currentDay == day
                                  ? colors.primary
                                  : day < currentDay
                                      ? Colors.grey
                                      : const Color(0xff1a1c1e),
                              fontWeight: currentDay == day
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: size.width * 0.08,
                              height: size.width * 0.08,
                              decoration: currentDay == day
                                  ? BoxDecoration(
                                      color: colors.primary,
                                      borderRadius: BorderRadius.circular(50))
                                  : null,
                            ),
                            Text(
                              day.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                color: currentDay == day
                                    ? Colors.white
                                    : day < currentDay
                                        ? Colors.grey
                                        : const Color(0xff1a1c1e),
                              ),
                            ),
                          ],
                        ),
                        // Convertir a String usando toString()
                      ],
                    ),
                  ));
            })
            .values
            .toList(),
      ),
    );
  }
}
