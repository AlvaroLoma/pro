import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class utilReservasProfesor extends StatefulWidget {
  const utilReservasProfesor({Key? key}) : super(key: key);

  @override
  State<utilReservasProfesor> createState() => _utilReservasProfesorState();
}

class _utilReservasProfesorState extends State<utilReservasProfesor> {
  List<String> carritosReserva = [];
  List<String> profesorReserva = [];
  List<String> fechaReserva = [];
  List<String> horaReserva = [];
  int numberRerservas=0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getReservas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (contex, index) => tile(index),
              separatorBuilder: (context, index) =>
              const Divider(height: 10, color: Colors.black87),
              itemCount: numberRerservas);
        }
      },
    );
  }

  tile(int index){

    return Container(
      height: 300,
      width: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 35,
              left: 5,
              child: Container(
                width: 150,
                height:100,
                decoration:const BoxDecoration(
                  color: Colors.orangeAccent,

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5)

                  ),
                ),
              )
          ),
          Positioned(
            top:110,
            left: 0,
            child: Container(
              child: Image.asset(
                "assets/image/carritoDis.png",
                width: 20,
              ),
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
              top: 70,
              left: 20,
              child: Text("Dia: ${ fechaReserva[index]}")
          ),
          Positioned(
              top: 100,
              left: 40,
              child: Text("Hora: ${ horaReserva[index]}")
          ),
          Positioned(
              top: 115,
              left: 40,
              child: Text("Carrito ${ carritosReserva[index]}")
          ),
          Positioned(
              top: 50,
              left: 20,
              child: Text("Prof: ${ profesorReserva[index]}")
          ),

        ],
      ),
    );

  }

  getReservas() async {
    QuerySnapshot query1= await FirebaseFirestore.instance.collection('Profesor').where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
    Map? mapa1 = query1.docs.elementAt(0).data() as Map?;
    numberRerservas=0;
    QuerySnapshot query =await FirebaseFirestore.instance.collection('Reservas').where("profesor", isEqualTo: "Alvaro loma").get();
    numberRerservas = query.docs.length;

    for (var e = 0; e <query.docs.length; e++) {
      Map? mapa = query.docs.elementAt(e).data() as Map?;
      profesorReserva.add(mapa!['profesor']);
      fechaReserva.add(mapa['fecha']);
      horaReserva.add(mapa['hora']);
      carritosReserva.add(mapa["idcarrito"]);
    }
  }

}
