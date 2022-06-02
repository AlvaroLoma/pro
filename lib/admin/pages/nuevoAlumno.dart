import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevoAlumno extends StatefulWidget {
  const NuevoAlumno({Key? key}) : super(key: key);

  @override
  State<NuevoAlumno> createState() => _NuevoAlumnoState();
}

class _NuevoAlumnoState extends State<NuevoAlumno> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  RegExp validateEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String userName = "";
  String passWord = "";

  String nombre = "";
  String apellidos = "";
  String contrasenia = "";
  String curso = "";
  String observaciones = "";
  String email = "";

  final _formulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nuevo Alumno"),
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(50, 40, 50, 50),
              child: Column(children: [
                Image.asset(
                  "assets/image/adduser.png",
                  width: 250,
                ),
                Form(
                    key: _formulario,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: _textController1,
                            decoration: const InputDecoration(
                              labelText: "Nombre del usuario",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              nombre = valorCampo.toString();
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: _textController1,
                            decoration: const InputDecoration(
                              labelText: "Apellidos",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              apellidos = valorCampo.toString();

                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: _textController1,
                            decoration: const InputDecoration(
                              labelText: "Contraseña",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              contrasenia = valorCampo.toString();
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: _textController1,
                            decoration: const InputDecoration(
                              labelText: "Email",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              email = valorCampo.toString();
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: _textController1,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              labelText: "Observaciones",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              observaciones = valorCampo.toString();
                              return null;
                            },
                          ),
                        ),
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
                                "Registrar",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]),
            ),
          ),
        ));
  }
}
