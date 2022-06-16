import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../qr/qrlector.dart';

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
  List<String> alumnos = [
    'Alvaro Lodeiro',
    'Palma Rodriguez',
    'Alberto Lopez',
    'Jose luis Perez',
    'Roberto Gonzalez'
  ];
  String alumnosValue = 'Alvaro Lodeiro';

  List<String> cursos = ['1a', '1b', '2a', '2b', '3a', '3b', '4a', '4b'];
  String cursoValue = '1a';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prestamo"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                                DropdownButton<String>(
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
                                )
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Row(
                              children: [
                                Text('Alumno'),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0)),
                                DropdownButton<String>(
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
                                )
                              ],
                            )),

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

                              }
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
}
