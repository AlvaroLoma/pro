import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class utilPrestamos extends StatefulWidget {
  const utilPrestamos({Key? key}) : super(key: key);

  @override
  State<utilPrestamos> createState() => _utilPrestamosState();
}

class _utilPrestamosState extends State<utilPrestamos> {
  List<String> disPrestamos = [];
  var numPrestamos = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPrestamos(),
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
              itemCount: numPrestamos);
        }
      },
    );
  }
  getPrestamos() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('Prestamos').get();
    numPrestamos =query.docs.length;
    for (var e = 0; e < numPrestamos; e++) {
       Map? mapa = query.docs.elementAt(e).data() as Map?;

       disPrestamos.add(mapa!["idDispositivo"]);
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
              width: 150,
              height: 60,
              decoration:const BoxDecoration(
                 color: Colors.orange,
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
            top: 0,
            left: 50,
            child: Container(
              child: Image.asset(
                "assets/image/miniPrestamo.png",
                width: 50,
              ),
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
          ),
        Positioned(
            top: 60,
            left: 30,
            child: Text("Dis: ${ disPrestamos[index]}")
          ),

        ],
      ),
    );

  }

}
