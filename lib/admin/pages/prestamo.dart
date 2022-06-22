import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



class Prestamo extends StatefulWidget {
  const Prestamo({Key? key}) : super(key: key);

  @override
  State<Prestamo> createState() => _PrestamoState();
}

class _PrestamoState extends State<Prestamo> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final _formulario = GlobalKey<FormState>();
  List<String> alumnos = [];
  String alumnosValue = '';

  List<String> cursos = [];
  String cursoValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prestamo"),
        leading: IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: () {  FirebaseAuth.instance.signOut(); Navigator.pop(context); },),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: _buildQrView(context),
                  width: 600,
                  height: 200,
                ),
                Form(
                    key: _formulario,
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Text('Curso'),
                                const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                                FutureBuilder(
                                    future: cursosObtener() ,
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return DropdownButton<String>(
                                          value: cursoValue,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style:
                                          const TextStyle(color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              alumnosValue="";
                                              cursoValue = newValue!;
                                            });
                                          },
                                          items: cursos.map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        );}
                                    }
                                ),


                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Text('Alumno'),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                                FutureBuilder(
                                    future: obtenerAlumnos() ,
                                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return DropdownButton<String>(
                                          value: alumnosValue,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style:
                                          const TextStyle(color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              alumnosValue = newValue!;
                                            });
                                          },
                                          items: alumnos.map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                        );}
                                    }
                                ),

                              ],
                            )),

                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
                            onPressed: () {
                              _formulario.currentState!.save();
                              realizarPrestamo();
                            },
                            child: Container(
                              child: const Text(
                                "Realizar prestamo",
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
      ),
    );
  }
  Future<void> cursosObtener() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('Curso').get();
    cursos=[];
    for (var e = 0; e < query.docs.length; e++) {

      Map? mapa = query.docs.elementAt(e).data() as Map?;
      cursos.add(mapa!["Curso"]);
      if(cursoValue.isEmpty){
        cursoValue=mapa["Curso"];
      }
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 70,
          borderWidth: 15,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {

    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  obtenerAlumnos() async {

    QuerySnapshot query= await FirebaseFirestore.instance.collection('Alumno').where("curso", isEqualTo: cursoValue).get();
    alumnos.clear();
    for (var e = 0; e < query.docs.length; e++) {
      Map? mapa = query.docs.elementAt(e).data() as Map?;
      alumnos.add(mapa!["Nombre"]+" "+mapa["Apellido"]);
      if(alumnosValue.isEmpty){
        alumnosValue=mapa["Nombre"]+" "+mapa["Apellido"];
      }
    }

  }

  Future<void> realizarPrestamo() async {

    if(result?.code != null){
      QuerySnapshot query= await FirebaseFirestore.instance.collection('Alumno').where("Nombre", isEqualTo: alumnosValue.split(" ")[0]).get();
      Map? mapa = query.docs.elementAt(0).data() as Map?;
      QuerySnapshot query2= await FirebaseFirestore.instance.collection('Prestamos').get();

      FirebaseFirestore.instance.collection('Prestamos').add({
        "idAlumno":mapa!['id'],
        "idDispositivo":result?.code,
        "idPrestamo": query2.docs.length+1

      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prestamo realizado')),
      );

    }
  }
}
