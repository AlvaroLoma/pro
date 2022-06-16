import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/devolucion.dart';

import 'pages/prestamo.dart';
import 'pages/principal.dart';


enum ViewType { incidencias, prestamos, reservas }

class PantallaPrincipalAlumno extends StatefulWidget {
  const PantallaPrincipalAlumno({Key? key}) : super(key: key);

  @override
  State<PantallaPrincipalAlumno> createState() =>
      _PantallaPrincipalAlumnoState();
}

class _PantallaPrincipalAlumnoState extends State<PantallaPrincipalAlumno> {
  int _selectedIndex = 0;
  static const List<Widget> _paginas = <Widget>[
    Principal(),
    Prestamo(),
    Devolucion(),
    //carrito impostor

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
            icon: Icon(Icons.add_circle),
            label: 'Prestamo',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward_outlined),
            label: 'Devolucion',
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
