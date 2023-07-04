import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/config/helpers/validators_date.dart';
import 'package:gym_app/infrastructure/models/reservas_model.dart';
import 'package:gym_app/src/providers/reservas/reservas_provider.dart';
import 'package:gym_app/src/providers/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:gym_app/src/shared/data/semana_data.dart';

class DialogReservation extends StatefulWidget {
  final int bloque, dia;
  final String acceso, idReserva;

  const DialogReservation(
      {super.key,
      required this.bloque,
      required this.dia,
      required this.acceso,
      required this.idReserva});

  @override
  State<DialogReservation> createState() => _DialogReservationState();
}

// widget.idReserva

class _DialogReservationState extends State<DialogReservation> {
  @override
  Widget build(BuildContext context) {
    final reservaProvider = context.watch<ReservaProvider>();
    final userProvider = context.watch<UserProvider>();
    final colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final int bloqueFinal = widget.bloque + 1;
    String diaReserva = processDay(widget.dia);
    String diaReservaTest = diaReserva;
    diaReservaTest = diaReservaTest.substring(0, 2);
    List<dynamic>? horarioBloque = getHour(widget.bloque);
    String entradaBloque = '';
    String salidaBloque = '';
    if (horarioBloque != null && horarioBloque.isNotEmpty) {
      String entrada = horarioBloque[0];
      String salida = horarioBloque[1];
      entradaBloque = entrada;
      salidaBloque = salida;
    }
    String tipoDate = 'completo';
    String? fechaActual = getDate(tipoDate);
    String fechaReserva = dateReservation(diaReservaTest);
    PageController pageController = PageController(initialPage: 0);
    List<String> accessReservation = getValidatorReservation();
    String motivoReserva = '';

    void scrollToPage(int pageNumber) {
      pageController.animateToPage(
        pageNumber,
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeInOut,
      );
    }

    return widget.acceso == 'Autorizado'
        ? PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              //inicio primera pagina
              AlertDialog(
                title: const Text(
                  'Realizar Reserva',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Estimad@ alumn@ ',
                              ),
                              TextSpan(
                                text: 'NOMBRE',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                text: 'APELLIDO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ', ¿Se encuentra ',
                              ),
                              TextSpan(
                                text: 'SEGURO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' que desea realizar esta ',
                              ),
                              TextSpan(
                                text: 'RESERVACION',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '?',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            '1. BLOQUE N° $bloqueFinal',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            '2. Dia: $diaReserva $fechaReserva',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            '3. Hora Ingreso: $entradaBloque',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            '4. Hora Salida: $salidaBloque',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            '5. Fecha Actual: $fechaActual',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            '6. Proposito:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: DropdownButtonFormField(
                            hint: const Text('Seleccione una opcion'),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: optionesProposito.map((proposito) {
                              return DropdownMenuItem(
                                value: proposito,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    proposito['icono'],
                                    Text(proposito['tipoProposito']),
                                    const SizedBox(),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              motivoReserva = value?['tipoProposito'];
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                    width: size.width * 0.30,
                    child: FloatingActionButton(
                      onPressed: () async {
                        DateTime now = DateTime.now();
                        scrollToPage(1);
                        //PARA MANGINI LOCO
                        // Lunes -> Indice de columna "0"
                        // Martes -> Indice de columna "1"
                        //Usa: reservasProvider.diasSemanaFechaCompleta[ indice de la columna ]
                        //Para obtener la fecha, en formato DateTime y solucionar el error. :)
                        final newReserva = ReservaModel(
                          bloque: bloqueFinal,
                          confirmada: false,
                          dia: diaReserva,
                          entrada: entradaBloque,
                          salida: salidaBloque,
                          uid: userProvider.user!.uid,
                          motivo: motivoReserva,
                          fecha: '$diaReserva $fechaReserva',
                          createdAt: now,
                        );
                        await reservaProvider.createNewReserva(newReserva);
                      },
                      backgroundColor: colors.primary,
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              //final primera pagina

              //inicio tercera pagina
              AlertDialog(
                content: SingleChildScrollView(
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.width * 0.45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: const Offset(1, 1),
                                blurRadius: 8,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/check2.png',
                                  height: size.width * 0.25,
                                  width: size.width * 0.25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.15,
                          width: double.infinity,
                          child: const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    'La reserva se realizo con exito',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Center(
                    child: TextButton(
                      child: const Text('Cerrar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        //enviar los datos para realizar la reserva
                      },
                    ),
                  ),
                ],
              )
              //fin tercera pagina
            ],
          )
        : widget.acceso == 'Denegado'
            ? AlertDialog(
                content: SingleChildScrollView(
                  child: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.width * 0.45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: const Offset(1, 1),
                                blurRadius: 8,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/notaccess.png',
                                  height: size.width * 0.25,
                                  width: size.width * 0.25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: accessReservation[0] == diaReserva
                              ? size.width * 0.48
                              : size.width * 0.36,
                          width: double.infinity,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    'Reserva Denegada',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    'Recuerda que para solicitar una reserva se debe realizar con un dia de anticipacion',
                                    style: TextStyle(
                                      fontSize: 14,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              if (accessReservation[0] == diaReserva)
                                const Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Center(
                                    child: Text(
                                      'Si desea inscribirse el mismo dia queda a criterio del que se encuentre a cargo',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            : widget.acceso == 'Reservado'
                ? AlertDialog(
                    content: SingleChildScrollView(
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: size.width * 0.45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: const Offset(1, 1),
                                    blurRadius: 8,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Image.asset(
                                      'assets/images/notaccess.png',
                                      height: size.width * 0.25,
                                      width: size.width * 0.25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: accessReservation[0] == diaReserva
                                  ? size.width * 0.48
                                  : size.width * 0.31,
                              width: double.infinity,
                              child: const Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text(
                                        'Reservacion Denegada',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text(
                                        'Recuerda que solo puedes reservar un bloque',
                                        style: TextStyle(
                                          fontSize: 14,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                : AlertDialog(
                    content: SingleChildScrollView(
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: size.width * 0.45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: const Offset(1, 1),
                                    blurRadius: 8,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: const Stack(
                                children: [
                                  Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.circleQuestion,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: accessReservation[0] == diaReserva
                                  ? size.width * 0.48
                                  : size.width * 0.31,
                              width: double.infinity,
                              child: const Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text(
                                        'Eliminando..',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text(
                                        'Se encuentra seguro que desea eliminar esta reserva',
                                        style: TextStyle(
                                          fontSize: 14,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        height: size.width * 0.1,
                        width: size.width * 0.30,
                        child: FloatingActionButton(
                          onPressed: () {
                            reservaProvider.deleteReserva(widget.idReserva);
                            Navigator.of(context).pop();
                          },
                          backgroundColor: colors.primary,
                          child: const Text(
                            'Confirmar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
  }
}
