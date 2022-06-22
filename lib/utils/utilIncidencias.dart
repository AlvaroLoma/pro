import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class utilIncidencias extends StatefulWidget {
  const utilIncidencias({Key? key}) : super(key: key);

  @override
  State<utilIncidencias> createState() => _utilIncidenciasState();
}

class _utilIncidenciasState extends State<utilIncidencias> {
  List<String> disIncidencias = [];
  List<String> estadoIncidencias = [];
  int numIndicencias=0;
  @override
  Widget build(BuildContext context) {
   return FutureBuilder(
      future: getIncidencias(),
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
              itemCount: numIndicencias);
        }
      },
    );
  }
  getIncidencias() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('Incidencias').get();
    numIndicencias = query.docs.length;

    for (var e = 0; e < numIndicencias; e++) {
      Map? mapa = query.docs.elementAt(e).data() as Map?;
        disIncidencias.add(mapa!["idDispositivo"]);
        estadoIncidencias.add(mapa["idEstado"]);
    }
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
                width: 180,
                height: 100,
                decoration:const BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)
                    )
                ),
              )
          ),
          Positioned(
            top: 30,
            left: 0,
            child: Container(
              child: Icon(Icons.warning,color: Colors.white,),
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
              top: 60,
              left: 50,
              child: Text("Dis: ${ disIncidencias[index]}")
          ),
          Positioned(
              top: 80,
              left: 50,
              child: Text("Estado: ${ estadoIncidencias[index]}")
          ),

        ],
      ),
    );

  }

}
