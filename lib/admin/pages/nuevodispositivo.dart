import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NuevoDispositivo extends StatefulWidget {
  const NuevoDispositivo({Key? key}) : super(key: key);

  @override
  State<NuevoDispositivo> createState() => _NuevoDispositivoState();
}

class _NuevoDispositivoState extends State<NuevoDispositivo> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  RegExp validateEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String userName = "";
  String passWord = "";
  List<String> estados = ['bueno', 'con incidencia'];
  String sdropdownValue = 'bueno';

  final _formulario = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo Dispositivo"),
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
          child: Column(
            children: [
              Image.asset(
                "assets/image/addDispositivo.png",
                width: 250,
              ),
              Form(
                  key: _formulario,
                  child: Column(
                    children: [
                      Text('FALTA AÑADIR EL BOTON PARA LEER EL QR'),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            children: [
                              Text('Estado'),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                              DropdownButton<String>(
                                value: sdropdownValue,
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
                                    sdropdownValue = newValue!;
                                  });
                                },
                                items: estados.map<DropdownMenuItem<String>>(
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
                              "Añadir",
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
    );
  }
}
