import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class listCarritos extends StatefulWidget {
  const listCarritos({Key? key}) : super(key: key);

  @override
  State<listCarritos> createState() => _listCarritosState();
}

class _listCarritosState extends State<listCarritos> {
  List<String> idCarritos=[];
  List<bool> reservadosCarritos=[];
  List<String> ubicacionCarritos=[];
  List<String> numDispositivos=[];
  List <String> disEnCarrito=[];


  int numCarritos=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carritos'),),
      body: Center(
        child: Column(
          children:[
            Expanded(
              child: Container(
                
                child:FutureBuilder(
                  future: getCarritos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (contex, index) => tileCarrito(index),
                          separatorBuilder: (context, index) =>
                          const Divider(height: 10, color: Colors.black87),
                          itemCount: numCarritos);
                    }
                  },
                ) ,
              ),
            ),
          ]
        ),
      ),
    );
  }

  getCarritos() async {

    QuerySnapshot query = await FirebaseFirestore.instance.collection('Carritos').get();
    numCarritos = query.docs.length;

    for (var e = 0; e < numCarritos; e++) {

      Map? mapa = query.docs.elementAt(e).data() as Map?;
      print(mapa);
      idCarritos.add(mapa!["id"]);
      reservadosCarritos.add(mapa["reservado"]);
      ubicacionCarritos.add(mapa["ubicacion"]);
      numDispositivos.add(mapa["dis"]);

      //cursosReservas.add(mapa["Curso"]);
      //carritosReservas.add(mapa["NomCarrito"]);
    }
  }

  tileCarrito(int index) {

    return ListTile(
      leading:reservadosCarritos.elementAt(index)? Image.asset("assets/image/carritoDis.png"):Image.asset("assets/image/carritoNo.png"),
      title: Text('carrito ${idCarritos.elementAt(index)}'),
      subtitle: Text(ubicacionCarritos.elementAt(index)),
      trailing: IconButton(onPressed: () {  }, icon: Icon(Icons.visibility),),
    );
  }
}
