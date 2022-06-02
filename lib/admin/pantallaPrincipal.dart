
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saladilloapp/admin/pages/principal.dart';

import 'package:saladilloapp/admin/prestamo.dart';
import 'package:saladilloapp/admin/reserva.dart';
import 'package:saladilloapp/utils/utilPrestamos.dart';


import 'pages/nuevoAlumno.dart';
import 'pages/nuevodispositivo.dart';

enum ViewType { incidencias, prestamos, reservas }

class pantallPrincipal extends StatefulWidget {
  const pantallPrincipal({Key? key}) : super(key: key);

  @override
  State<pantallPrincipal> createState() => _pantallPrincipalState();
}

class _pantallPrincipalState extends State<pantallPrincipal> {
  int _selectedIndex = 0;
  static const List<Widget> _paginas = <Widget>[
    principal(),
    Prestamo(),
    Reserva(),
    NuevoAlumno(),
    NuevoDispositivo(),
    NuevoDispositivo()//carrito impostor

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

        selectedFontSize: 15,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Principal',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Prestamo',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_sharp),
            label: 'Reserva',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Nuevo Alumno',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_queue),
            label: 'Dispositivo',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Crear Carrito',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),

    );
  }

}
