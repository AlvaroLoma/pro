import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reserva extends StatefulWidget {
  const Reserva({Key? key}) : super(key: key);

  @override
  State<Reserva> createState() => _ReservaState();
}

class _ReservaState extends State<Reserva> {
  int numCarritos = 0;
  @override
  void initState() {

    super.initState();
  }

  TextEditingController dateinput = TextEditingController();
  final _formulario = GlobalKey<FormState>();
  List<String> nombreCarrito = [];
  List<int> numDispositivos = [];
  List<String> ubicacionCarrito = [];
  String nombreCarritoValue = "";
  String ubicacionCarritoValue = "";
  int numDispositivosValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserva"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
        child: Column(
          children: [
            Image.asset(
              "assets/image/reserva.png",
              width: 250,
            ),
            SingleChildScrollView(
              child: Form(
                  key: _formulario,
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: getCarritos(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Container(

                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                child: Row(
                                  children: [
                                    const Text('Carrito'),
                                    const Padding(padding:EdgeInsets.fromLTRB(0, 0, 10, 0)),
                                    DropdownButton<String>(

                                      value: nombreCarritoValue,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.blue),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.blue,
                                      ),

                                      onChanged: (String? newValue) {
                                          setState(() {
                                            nombreCarritoValue = newValue!;
                                          });
                                      },
                                      items: nombreCarrito.map<DropdownMenuItem<String>>((String value) {return DropdownMenuItem<String>(value: value, child: Text(value),);}).toList(),
                                    ),

                                  ],
                                ));
                          }
                        },
                      ),

                      Container(
                          padding: EdgeInsets.all(15),
                          height: 150,
                          child: Center(
                              child: TextField(
                            controller:
                                dateinput, //editing controller of this TextField
                            decoration: const InputDecoration(
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText:
                                    "Seleccione la fecha de la reserva" //label text of field
                                ),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dateinput.text = formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ))),
                      Text('HAY QUE ELEGIR CARRITO O SE LE ASIGNA RANDOM?'),
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
                                actualizar();
                            }
                          },
                          child: Container(
                            child: const Text(
                              "Realizar reserva",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getCarritos() async {

    if(nombreCarrito.length==0){
      String cadena="";
      QuerySnapshot query =
      await FirebaseFirestore.instance.collection('Carritos').get();

      numCarritos = query.docs.length;
      for (var e = 0; e < numCarritos; e++) {
        Map? mapa = query.docs.elementAt(e).data() as Map?;
        if (!mapa!['reservado']) {
          cadena=mapa['Nombre']+" "+ mapa['ubicacion']+ " Dispositivos: "+(mapa["dis"].toString());
          nombreCarrito.add(cadena);
          nombreCarritoValue=cadena;

        }
        
      }

    }

  }
  
  actualizar() async {

    await FirebaseFirestore.instance.doc('Carritos/C01').update({'reservado':true});
  }
}
