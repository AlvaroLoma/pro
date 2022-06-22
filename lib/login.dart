import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saladilloapp/alumno/pantallaPrincipalAlumno.dart';
import 'package:saladilloapp/profesor/pantallaPrincipal.dart';
import 'package:saladilloapp/profesor/pages/registarse.dart';

import 'admin/pantallaPrincipal.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  RegExp validateEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String userName = "";
  String passWord = "";
  late FirebaseAuth auth;

  final _formulario = GlobalKey<FormState>();
  @override
  void initState() {
    fireb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),

      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Column(
            children: [
              Image.asset(
                "assets/image/login.png",
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
                          decoration: const InputDecoration(labelText: "Usuario",),
                          keyboardType: TextInputType.name,
                          validator: (valorCampo) {
                            if (validateEmail.hasMatch(valorCampo!)) {
                              userName = valorCampo.toString();
                            } else {
                              return "Correo no valido";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextFormField(
                          controller: _textController2,
                          obscureText: true,
                          decoration: const InputDecoration(labelText: "Contraseña"),
                          keyboardType: TextInputType.name,
                          validator: (valorCampo) {
                            if (valorCampo!.isNotEmpty) {
                              passWord = valorCampo.toString();
                              return null;
                            } else {
                              return "Contraseña vacia";
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            _formulario.currentState!.save();
                            if (_formulario.currentState!.validate()) {
                              //Navigator.push(_formulario.currentContext!, MaterialPageRoute(builder: (context)=>const Games()));
                              validateUser(_formulario.currentContext).then((value) => {
                                if (value){
                                  navigate(_formulario.currentContext!)
                                }
                              });
                            }
                          },
                          child: Container(
                            child: const Text(
                              "Acceder",
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

  Future<bool> validateUser(BuildContext? currentContext) async {
    bool flag = true;
    try {
      await auth.signInWithEmailAndPassword(email: userName, password: passWord);
    } on FirebaseAuthException catch (e) {
      flag = false;
      ScaffoldMessenger.of(currentContext!).showSnackBar(SnackBar(
        content: Text(
          e.code.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 30),
        ),
      ));
    } catch (e) {
      flag = false;
    }
    return flag;
  }

  Future<void> fireb() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBFUzMIqNRDTwgj4kfLLy3wizEWt-sjf04",
            appId: "1:799168187419:android:17164bfc5e93c384287cbe",
            messagingSenderId: "TDWB2mSfB5X2uTmHbKrz4YDF4LR2",
            projectId: "proyectofinal-87abe"));
    auth = FirebaseAuth.instance;
  }

  navigate(BuildContext buildContext) {
    _textController1.clear();
    _textController2.clear();
    if (auth.currentUser!.email!.endsWith("admin.es")) {
      Navigator.push(buildContext,
          MaterialPageRoute(builder: (context) => const pantallPrincipal()));
    } else if (auth.currentUser!.email!.endsWith("profesor.es")) {
      Navigator.push(
          buildContext,
          MaterialPageRoute(builder: (context) => const pantallaPrincipalProfesor()));
    }else{
      Navigator.push(
          buildContext,
          MaterialPageRoute(builder: (context) => const PantallaPrincipalAlumno()));
    }
    // Navigator.push(buildContext, MaterialPageRoute(builder: (context)=>const Chat()));
  }
}
