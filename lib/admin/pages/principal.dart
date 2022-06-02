import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/utilPrestamos.dart';
import '../../utils/utilText.dart';
enum ViewType { incidencias, prestamos, reservas }
class principal extends StatefulWidget {
  const principal({Key? key}) : super(key: key);

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> {
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
      ),
      body: Center(
        child: Column(
          children: [
            utilText('Reservas', 25, numberRerservas),
            Container(
              margin: margin,
              height: 100,
              child: getListView(ViewType.reservas),
            ),
            utilText('Prestamos', 25, numPrestamos),
            Container(
              margin: margin,
              height: 150,
              child: getListView(ViewType.prestamos),
            ),
            utilText('Incidencias', 25, numIndicencias),
            Container(
              margin: margin,
              height: 100,
              child: getListView(ViewType.incidencias),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),

          ],
        ),
      ),
    );
  }

  getListView(ViewType type) {
    switch (type) {
      case ViewType.incidencias:
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
                  itemBuilder: (contex, index) => tileIncidencias(index),
                  separatorBuilder: (context, index) =>
                  const Divider(height: 10, color: Colors.black87),
                  itemCount: numIndicencias);
            }
          },
        );
        break;
      case ViewType.prestamos:
        return utilPrestamos();
      case ViewType.reservas:
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
                  itemBuilder: (contex, index) => tileReserva(index),
                  separatorBuilder: (context, index) =>
                  const Divider(height: 10, color: Colors.black87),
                  itemCount: numberRerservas);
            }
          },
        );
        break;
    }
  }
  tile(int index){
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              top: 32, left: 8, right: 8, bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.blue
                        .withOpacity(0.6),
                    offset: const Offset(1.1, 4.0),
                    blurRadius: 8.0),
              ],

              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(54.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 54, left: 16, right: 16, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'holi',
                    textAlign: TextAlign.center,
                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.2,
                      color:Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                          'holi',
                            style: TextStyle(

                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              letterSpacing: 0.2,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                       'adios',
                        textAlign: TextAlign.center,
                        style: TextStyle(

                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          letterSpacing: 0.2,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4, bottom: 3),
                        child: Text(
                          'kcal',
                          style: TextStyle(

                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            letterSpacing: 0.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color:Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 8,
          child: SizedBox(
            width: 80,
            height: 80,
            //child: Image.asset(mealsListData!.imagePath),
          ),
        )
      ],
    );

  }

  tileReserva(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 1, 5),
      decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      width: 200,
      child: ListTile(
        leading: Text(cursosReservas.elementAt(index)),
        title: Text(aulasReservas.elementAt(index)),
        subtitle: Text(carritosReservas.elementAt(index)),
      ),
    );
  }

  getReservas() async {
    //QuerySnapshot query =
    // await FirebaseFirestore.instance.collection('Reservas').get();
    numberRerservas = 0;
    //query.docs.length;

    for (var e = 0; e < numberRerservas; e++) {
      //Map? mapa = query.docs.elementAt(e).data() as Map?;
      //aulasReservas.add(mapa!["Aula"]);
      //cursosReservas.add(mapa["Curso"]);
      //carritosReservas.add(mapa["NomCarrito"]);
    }
  }


  tileIncidencias(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 1, 5),
      decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      width: 300,
      child: ListTile(
        title: Text(disIncidencias.elementAt(index)),
        subtitle: Text(incidencias.elementAt(index)),
      ),
    );
  }

  getIncidencias() async {
    // QuerySnapshot query =
    // await FirebaseFirestore.instance.collection('Incidencias').get();
    numIndicencias = 0;
    //query.docs.length;

    for (var e = 0; e < numIndicencias; e++) {
      // Map? mapa = query.docs.elementAt(e).data() as Map?;
      // disIncidencias.add(mapa!["Dispositivo"]);
      //incidencias.add(mapa["incidencia"]);
    }
  }
}
