import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Devolucion extends StatefulWidget {
  const Devolucion({Key? key}) : super(key: key);

  @override
  State<Devolucion> createState() => _DevolucionState();
}

class _DevolucionState extends State<Devolucion> {
  String _observaciones ="";

  final TextEditingController _textController1 = TextEditingController();
  List<String> estados = ['Sin incidencia', 'con incidencia'];
  String sdropdownValue = 'Sin incidencia';
  List<String> listIncidencias=[];
  String listValue ='abierta';
  Barcode? result;
  QRViewController? controller;
  final _formulario = GlobalKey<FormState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Devoluciones"),
        leading: IconButton(icon: Icon(Icons.keyboard_backspace), onPressed: () {  FirebaseAuth.instance.signOut(); Navigator.pop(context); },),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Column(
                  children: [

                    Container(
                      child: _buildQrView(context),
                      width: 600,
                      height: 200,
                    ), //qr
                    Row( //botones qr
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 100,
                            height: 50,
                            margin: const EdgeInsets.all(8),
                            child:
                            IconButton(
                              icon: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Icon(Icons.wb_incandescent);
                                },
                              ), onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {}); },)
                        ),
                        Container(
                            width: 100,
                            height: 50,
                            margin: const EdgeInsets.all(8),
                            child:
                            IconButton(
                              icon: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  return Icon(Icons.wifi_protected_setup);
                                },
                              ), onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {}); },)
                        )
                      ],
                    ),

                    if (result != null)
                      Text('Numero del dispositivo: ${result!.code}')
                    else
                      const Text('Escanea el codigo'),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          children: [
                            Text('Estado'),
                            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                            DropdownButton<String>(
                              value: sdropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  sdropdownValue = newValue!;
                                });
                              },
                              items: estados.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            )
                          ],
                        )),
                    if(sdropdownValue=='con incidencia')
                      Form(

                        key: _formulario,
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  children: [
                                    Text('Estado'),
                                    const Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                                    FutureBuilder(
                                        future: estadosIncidencias() ,
                                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          } else {
                                            return DropdownButton<String>(
                                              value: listValue,
                                              icon: const Icon(Icons.arrow_downward),
                                              elevation: 16,
                                              style: const TextStyle(color: Colors.deepPurple),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  listValue = newValue!;
                                                });
                                              },
                                              items: listIncidencias.map<DropdownMenuItem<String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                            ); }
                                        }
                                    )
                                  ],
                                )),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: TextFormField(
                                controller: _textController1,
                                maxLines: 6,
                                decoration: const InputDecoration(
                                  labelText: "Observaciones",
                                ),
                                keyboardType: TextInputType.name,
                                validator: (valorCampo) {
                                  _observaciones = valorCampo.toString();
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          _formulario.currentState!.save();
                          if (_formulario.currentState!.validate()) {
                            realizarDevolcion();

                          }

                        },
                        child: Container(
                          child: const Text(
                            "Realizar Devolucion",
                            style: TextStyle(color: Colors.black),
                          ),
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
    );
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


  Future<void> estadosIncidencias() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('EstadosIncidencias').get();
    if(listIncidencias.isEmpty){
      for (var e = 0; e < query.docs.length; e++) {
        Map? mapa = query.docs.elementAt(e).data() as Map?;
        listIncidencias.add(mapa!["estado"]);
      }
    }

  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> realizarDevolcion() async {

    if(result?.code != null){
      QuerySnapshot query= await FirebaseFirestore.instance.collection('Alumno').where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
      Map? mapa = query.docs.elementAt(0).data() as Map?;
      QuerySnapshot query3= await FirebaseFirestore.instance.collection('Devoluciones').get();
      FirebaseFirestore.instance.collection('Devoluciones').add({
        "idDispositivo":result?.code,
        "idAlumno": mapa!['id'],
        "idDevolucion":query3.docs.length+1

      });
      if(sdropdownValue=='con incidencia'){
        QuerySnapshot query2= await FirebaseFirestore.instance.collection('Incidencias').get();

        FirebaseFirestore.instance.collection('Incidencias').add({
          "idDispositivo":result?.code,
          "observaciones": _observaciones,
          "idIncidencia":query2.docs.length+1,
          "idEstado":listValue
        });
      }
    }

  }
}
