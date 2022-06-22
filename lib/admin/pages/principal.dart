import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saladilloapp/admin/pages/nuevoCarrito.dart';
import 'package:saladilloapp/admin/pages/nuevoProfesor.dart';
import 'package:saladilloapp/admin/pages/nuevodispositivo.dart';
import 'package:saladilloapp/utils/utilIncidencias.dart';
import 'package:saladilloapp/utils/utilReservas.dart';

import '../../utils/utilPrestamos.dart';
import '../../utils/utilText.dart';
enum ViewType { incidencias, prestamos, reservas }
class principal extends StatefulWidget {
  const principal({Key? key}) : super(key: key);

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> {
  EdgeInsets margin=const EdgeInsets.fromLTRB(10, 5, 1, 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
        leading: IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: () {  FirebaseAuth.instance.signOut(); Navigator.pop(context); },),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              utilText('Reservas'),
              Container(
                margin: margin,
                height: 150,
                child: getListView(ViewType.reservas),
              ),
              utilText('Prestamos'),
              Container(
                margin: margin,
                height: 100,
                child: getListView(ViewType.prestamos),
              ),
              utilText('Incidencias'),
              Container(
                margin: margin,
                height: 100,
                child: getListView(ViewType.incidencias),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0, 50, 0, 0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const nuevoCarrito()));
                      },
                      child: const Text('Nuevo carrito')
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const NuevoDispositivo()));
                      },
                      child: const Text('Nuevo Dispositivo')
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const NuevoProfesor()));
                      },
                      child: const Text('Crear Profesor')
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getListView(ViewType type) {
    switch (type) {
      case ViewType.incidencias:
        return const utilIncidencias();
      case ViewType.prestamos:
        return const utilPrestamos();
      case ViewType.reservas:
        return const utilReservas();
    }
  }









}
