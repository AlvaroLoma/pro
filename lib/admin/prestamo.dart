import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../qr/qrlector.dart';

class Prestamo extends StatefulWidget {
  const Prestamo({Key? key}) : super(key: key);

  @override
  State<Prestamo> createState() => _PrestamoState();
}

class _PrestamoState extends State<Prestamo> {
  final _formulario = GlobalKey<FormState>();
  List<String> alumnos = [
    'Alvaro Lodeiro',
    'Palma Rodriguez',
    'Alberto Lopez',
    'Jose luis Perez',
    'Roberto Gonzalez'
  ];
  String alumnosValue = 'Alvaro Lodeiro';

  List<String> cursos = ['1a', '1b', '2a', '2b', '3a', '3b', '4a', '4b'];
  String cursoValue = '1a';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prestamo"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/image/prestamo.png",
                  width: 250,
                ),
                Form(
                    key: _formulario,
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Text('Curso'),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                                DropdownButton<String>(
                                  value: cursoValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      cursoValue = newValue!;
                                    });
                                  },
                                  items: cursos.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Text('Alumno'),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                                DropdownButton<String>(
                                  value: alumnosValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      alumnosValue = newValue!;
                                    });
                                  },
                                  items: alumnos.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )
                              ],
                            )),
                        Text('FALTA AÑADIR EL BOTON PARA LEER EL QR'),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                            onPressed: () {
                              _formulario.currentState!.save();
                              if (_formulario.currentState!.validate()) {
                                //Navigator.push(_formulario.currentContext!, MaterialPageRoute(builder: (context)=>const Games()));

                              }
                            },
                            child: Container(
                              child: const Text(
                                "Realizar prestamo",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
