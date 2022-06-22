import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saladilloapp/profesor/pages/devolucion.dart';
import 'package:saladilloapp/profesor/pages/prestamo.dart';
import 'package:saladilloapp/profesor/pages/principal.dart';
import 'package:saladilloapp/profesor/pages/registarse.dart';
import 'package:saladilloapp/profesor/pages/reserva.dart';


enum ViewType { incidencias, prestamos, reservas }

class pantallaPrincipalProfesor extends StatefulWidget {
  const pantallaPrincipalProfesor({Key? key}) : super(key: key);

  @override
  State<pantallaPrincipalProfesor> createState() =>
      _pantallaPrincipalProfesorState();
}

class _pantallaPrincipalProfesorState extends State<pantallaPrincipalProfesor> {
  int _selectedIndex = 0;
  static const List<Widget> _paginas = <Widget>[
    principal(),
    Reserva(),
    Prestamo(),
    Devolucion(),
    Registrarse()

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
            icon: Icon(Icons.account_balance_wallet_sharp),
            label: 'Reserva',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Prestamo',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Devolucion',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Nuevo Alumno',
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
