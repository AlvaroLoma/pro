import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reserva extends StatefulWidget {
  const Reserva({Key? key}) : super(key: key);

  @override
  State<Reserva> createState() => _ReservaState();
}

class _ReservaState extends State<Reserva> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Devoluciones'),),
      body: Container(),
    );
  }
}
