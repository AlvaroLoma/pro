import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../admin/prestamo.dart';
import '../admin/reserva.dart';

enum ViewType { incidencias, prestamos, reservas }

class pantallaPrincipalProfesor extends StatefulWidget {
  const pantallaPrincipalProfesor({Key? key}) : super(key: key);

  @override
  State<pantallaPrincipalProfesor> createState() =>
      _pantallaPrincipalProfesorState();
}

class _pantallaPrincipalProfesorState extends State<pantallaPrincipalProfesor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {},
        ),
        title: Text('Titulo'),
        actions: [
          TextButton(
            onPressed: () => {},
            child: Text('Devolucion'),
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.fromLTRB(20, 20, 20, 20)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Reservas'),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 1, 5),
              height: 100,
              child: getListView(ViewType.reservas),
            ),
            Text('Prestamos'),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 1, 50),
              height: 100,
              child: getListView(ViewType.reservas),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Reserva()))
                  },
                  child: Text('Nueva Reserva'),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.fromLTRB(20, 20, 20, 20)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                ),
                TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.fromLTRB(20, 20, 20, 20)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Prestamo()))
                        },
                    child: Text('Nuevo Prestamo'))
              ],
            ),
          ],
        ),
      ),
    );
  }

  getListView(ViewType type) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (contex, index) => tileGenerator(index),
        separatorBuilder: (context, index) =>
            const Divider(height: 10, color: Colors.black87),
        itemCount: 10);
  }

  tileGenerator(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 1, 5),
      decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      width: 200,
      child: ListTile(
        selectedTileColor: Colors.red,
        leading: Text('1C'),
        title: Text('Aula informatica'),
        subtitle: Text('Carrito 1'),
      ),
    );
  }
}
