import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({Key? key}) : super(key: key);

  @override
  State<Registrarse> createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {
  List <String> cursos=[];
  String cursoValue="2b";
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();
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
          title: Text("Registro"),
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
                  width: 200,
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
                              labelText: "Nombre ",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              if(valorCampo.toString().isNotEmpty){
                                 nombre = valorCampo.toString();
                                 return null;

                              }

                              return "el campo nombre no debe estar vacio";
                            },
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: _textController2,
                            decoration: const InputDecoration(
                              labelText: "Apellidos",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              if(valorCampo.toString().isNotEmpty){
                                 apellidos = valorCampo.toString();
                                 return null;
                              }

                              return "el campo apellidos no debe estar vacio";
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: _textController3,
                            decoration: const InputDecoration(
                              labelText: "Contraseña",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              if(valorCampo.toString().isNotEmpty){
                                 contrasenia = valorCampo.toString();
                                return null;
                              }

                              return "el campo contraseña no puede estar vacio";
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextFormField(
                            controller: _textController4,
                            decoration: const InputDecoration(
                              labelText: "Email",
                            ),
                            keyboardType: TextInputType.name,
                            validator: (valorCampo) {
                              if(valorCampo.toString().isNotEmpty){
                                email = valorCampo.toString();
                                return null;

                              }
                              return 'el campo email no puede estar vacio';
                            },
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Text('Estado'),
                                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                                FutureBuilder(
                                    future: cursosObtener() ,
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return DropdownButton<String>(
                                          value: cursoValue,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(color: Colors.deepPurple),
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
                                        ); }
                                    }
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
                                registarse(_formulario.currentContext!);
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

  Future<void> cursosObtener() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('Curso').get();
      cursos=[];
      for (var e = 0; e < query.docs.length; e++) {
        print(2);
        Map? mapa = query.docs.elementAt(e).data() as Map?;
        cursos.add(mapa!["Curso"]);
        if(cursoValue.isEmpty){
          cursoValue=mapa["Curso"];
        }


      }
  }
  Future<void> registarse(BuildContext buildContext) async {

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: contrasenia);

      ScaffoldMessenger.of(buildContext).showSnackBar(const SnackBar(
        content: Text("Usuario creado con exito",textAlign: TextAlign.center,style: TextStyle( fontSize: 30),),
      ));
      try{
        QuerySnapshot query= await FirebaseFirestore.instance.collection('Alumno').get();
        FirebaseFirestore.instance.collection('Alumno').add({
          "id":query.docs.length+1,
          "Nombre":nombre,
          "Apellido":apellidos,
          "email": email,
          "curso":cursoValue,
          "prestamo":false
        });
      }on FirebaseException catch(e){
        print(e.message);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
        content: Text(e.code.toString(),textAlign: TextAlign.center,style: const TextStyle( fontSize: 30),),
      ));
    } catch (e) { }



  }
}
