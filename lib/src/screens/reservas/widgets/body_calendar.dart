import 'package:flutter/material.dart';
import 'package:gym_app/src/screens/reservas/widgets/grilla_calendar.dart';
import 'package:gym_app/src/shared/data/semana_data.dart';

class BodyCalendar extends StatelessWidget {
  const BodyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double parentHeight = constraints.maxHeight;
          // Utiliza parentWidth para realizar las operaciones que necesites
          // con el ancho del contenedor padre
          return Row(
            children: [
              Column(
                children: hours.map((hour) {
                  return Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: size.width * .15,
                    height: (parentHeight / 7),
                    child: Text(
                      hour['entrada'],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
              Expanded(
                child: GrillaCalendar(
                  heightGrilla: parentHeight / 8,
                  widthGrilla: 0.18,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
