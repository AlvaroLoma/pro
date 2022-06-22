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
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
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

  Future<void> realizarPrestamo() async {

    if(result?.code != null){
      QuerySnapshot query= await FirebaseFirestore.instance.collection('Alumno').where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
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
