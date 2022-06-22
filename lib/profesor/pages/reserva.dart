import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String nombreCarritoValue = "";
  List<String> ubicaciones = [];
  String ubicacionesValue="";
  String hora=DateTime.now().toString();

  List<String> horario=['1º hora','2º hora','3º hora','4º hora','5º hora','6º hora'];
  String horaValue='1º hora';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reserva"),
        leading: IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: () {  FirebaseAuth.instance.signOut(); Navigator.pop(context); },),
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

                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Row(
                            children: [
                              const Text('Hora'),
                              const Padding(padding:EdgeInsets.fromLTRB(0, 0, 10, 0)),
                              DropdownButton<String>(

                                value: horaValue,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(color: Colors.blue),
                                underline: Container(
                                  height: 2,
                                  color: Colors.blue,
                                ),

                                onChanged: (String? newValue) {
                                  setState(() {
                                    horaValue = newValue!;
                                  });
                                },
                                items: horario.map<DropdownMenuItem<String>>((String value) {return DropdownMenuItem<String>(value: value, child: Text(value),);}).toList(),
                              ),

                            ],
                          )),

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
                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

                                    print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      hora=DateFormat('yyyy-MM-dd').format(pickedDate).toString();
                                      dateinput.text = formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ))),

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
    String cadena="";
    QuerySnapshot query = await FirebaseFirestore.instance.collection('Carritos').get();
    numCarritos = query.docs.length;
    nombreCarrito=[];

    for (var e = 0; e < numCarritos; e++) {
      Map? mapa = query.docs.elementAt(e).data() as Map?;
      if (!mapa!['reservado']) {
        cadena="Carrito "+mapa['id'];
        nombreCarrito.add(cadena);
        if(nombreCarritoValue==""){
          nombreCarritoValue=cadena;
        }

      }

    }
  }

  actualizar() async {

    // await FirebaseFirestore.instance.doc('Carritos').update({'reservado':true});

    QuerySnapshot query= await FirebaseFirestore.instance.collection('Profesor').where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
    Map? mapa = query.docs.elementAt(0).data() as Map?;
    QuerySnapshot query3= await FirebaseFirestore.instance.collection('Reservas').get();
    FirebaseFirestore.instance.collection('Reservas').add({
      "idReserva":query3.docs.length+1,
      "idcarrito": nombreCarritoValue.split(" ")[1],
      "profesor":mapa!['nombre'],
      "fecha":hora,
      "hora":horaValue
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Reserva realizada",textAlign: TextAlign.center,style: TextStyle( fontSize: 30),),
    ));


  }


}
