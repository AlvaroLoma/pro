import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  String nombre = "";
  String apellidos = "";
  String curso = "";
  String email = "";
  String dispositivo="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumno'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: getAlumno(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2)),
                    margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                    width: 400,
                    height: 200,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            top: 20,
                            left: 10,
                            child: Image.asset(
                              "assets/image/userImage.png",
                            )),
                        Positioned(
                            top: 20,
                            left: 160,
                            child: Text(
                              '$nombre',
                              style: TextStyle(fontSize: 25),
                            )),
                        Positioned(
                            top: 60,
                            left: 160,
                            child: Text(
                              '$apellidos',
                              style: TextStyle(fontSize: 25),
                            )),
                        Positioned(
                            top: 100,
                            left: 160,
                            child: Text(
                              '$curso',
                              style: TextStyle(fontSize: 25),
                            )),
                        Positioned(
                            top: 150,
                            left: 15,
                            child: Text(
                              '$email',
                              style: TextStyle(fontSize: 20),
                            )),
                      ],
                    ),
                  );
                }
              },
            ),


          ],
        ),
      ),
    );
  }

  getAlumno() async {
    print(FirebaseAuth.instance.currentUser!.email);
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('Alumno')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    Map? mapa = query.docs.elementAt(0).data() as Map?;

    nombre = mapa!["Nombre"];
    apellidos = mapa["Apellido"];
    curso = mapa["curso"];
    email = mapa["email"];
  }


}
