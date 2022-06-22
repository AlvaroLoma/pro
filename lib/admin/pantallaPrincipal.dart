
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saladilloapp/admin/pages/devolucion.dart';
import 'package:saladilloapp/admin/pages/listCarritos.dart';

import 'package:saladilloapp/admin/pages/principal.dart';

import 'package:saladilloapp/admin/pages/prestamo.dart';
import 'package:saladilloapp/admin/pages/reserva.dart';

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
    Devolucion(),
    Reserva(),
    listCarritos(),
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
            icon: Icon(Icons.add),
            label: 'Prestamo',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: 'Devolucion',
            backgroundColor: Colors.blue,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Reserva',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Carritos',
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

