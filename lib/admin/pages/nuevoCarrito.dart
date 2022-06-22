import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class nuevoCarrito extends StatefulWidget {
  const nuevoCarrito({Key? key}) : super(key: key);

  @override
  State<nuevoCarrito> createState() => _nuevoCarritoState();
}

class _nuevoCarritoState extends State<nuevoCarrito> {
  final _formulario = GlobalKey<FormState>();
  final TextEditingController _textController1 = TextEditingController();
  String numMax='';
  List<String> ubicacion=[];
  String ubicacionValue='planta baja';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuevo Carrito'),leading: IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: () {   Navigator.pop(context); },),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Form(
                  key: _formulario,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/image/carrito.png",
                        width: 250,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          children: [
                            Text('Localizacion: '),
                            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                            FutureBuilder(
                                future: getUbicaciones() ,
                                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return DropdownButton<String>(
                                      value: ubicacionValue,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          ubicacionValue = newValue!;
                                        });
                                      },
                                      items: ubicacion.map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                    ); }
                                }
                            ),

                          ]
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextFormField(
                          controller: _textController1,
                          obscureText: false,
                          decoration:
                          const InputDecoration(labelText: "Nº Dispositivos"),
                          keyboardType: TextInputType.number,
                          validator: (valorCampo) {
                            if (valorCampo!.isNotEmpty) {
                              numMax = valorCampo.toString();
                              return null;
                            } else {
                              return "Introduzca el numero de dispositivos";
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            _formulario.currentState!.save();
                            if (_formulario.currentState!.validate()) {
                              print('bobo');
                              //Navigator.push(_formulario.currentContext!, MaterialPageRoute(builder: (context)=>const Games()));
                                crearCarrito();
                            }
                          },
                          child: Container(
                            child: const Text(
                              "Crear Carrito",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getUbicaciones() async {

    QuerySnapshot query = await FirebaseFirestore.instance.collection('CarritosUbicacion').get();
    if(ubicacion.isEmpty){
      for (var e = 0; e < query.docs.length; e++) {
        Map? mapa = query.docs.elementAt(e).data() as Map?;
        ubicacion.add(mapa!["planta"]);
      }
    }
  }

  Future<void> crearCarrito() async {
    print('bobo');
    QuerySnapshot query = await FirebaseFirestore.instance.collection('Carritos').get();

    FirebaseFirestore.instance.collection('Carritos').add({
      "id":query.docs.length.toString(),
      "dis": numMax,
      "reservado":false,
      'ubicacion':ubicacionValue
    });
  }
}
