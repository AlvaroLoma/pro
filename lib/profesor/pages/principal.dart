import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saladilloapp/utils/utilReservasProfesor.dart';

import '../../utils/utilPrestamos.dart';
import '../../utils/utilText.dart';

enum ViewType { incidencias, prestamos, reservas }
class principal extends StatefulWidget {
  const principal({Key? key}) : super(key: key);

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> {
  String nombre="";
  String email="";


  EdgeInsets margin=const EdgeInsets.fromLTRB(10, 5, 1, 5);
  var numberRerservas = 0;
  var numIndicencias = 0;
  var numPrestamos = 0;
  List<String> aulasReservas = [];
  List<String> cursosReservas = [];
  List<String> carritosReservas = [];
  List<String> cursosPrestamos = [];
  List<String> profPrestamos = [];
  List<String> alumnPrestamos = [];
  List<String> disPrestamos = [];
  List<String> disIncidencias = [];
  List<String> incidencias = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Principal'),
        leading: IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: () {  FirebaseAuth.instance.signOut(); Navigator.pop(context); },),
      ),
      body: Center(
        child: Column(
          children: [
            utilText('Reservas'),
            Container(
              margin: margin,
              height: 300,
              child: utilReservasProfesor(),
            ),

            FutureBuilder(
              future: getProfesor(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black,style: BorderStyle.solid,width: 2)),
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
                            )
                        ),
                        Positioned(
                            top: 40,
                            left: 160,
                            child: Text('$nombre',style: TextStyle(fontSize: 20),)
                        ),
                        Positioned(
                            top: 80,
                            left: 160,
                            child: Text( '$email',style: TextStyle(fontSize: 20),)
                        ),
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







  getProfesor() async {

    QuerySnapshot query= await FirebaseFirestore.instance.collection('Profesor').where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
    Map? mapa = query.docs.elementAt(0).data() as Map?;

    nombre=mapa!["Nombre"];
    email=mapa["email"];

  }
}
