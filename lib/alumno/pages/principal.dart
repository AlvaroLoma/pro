import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alumno'),),
      body: Center(
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black,style: BorderStyle.solid,width: 2)),
              margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
              width: 400,
              height: 200,

              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 20,
                      left: 10,
                      child: Image.asset(
                        "assets/image/userImage.png",
                      )
                  ),
                  Positioned(
                      top: 20,
                      left: 160,
                      child: Text('Nombre',style: TextStyle(fontSize: 25),)
                  ),
                  Positioned(
                      top: 50,
                      left: 160,
                      child: Text( 'Apellidos',style: TextStyle(fontSize: 25),)
                  ),
                  Positioned(
                      top: 80,
                      left: 160,
                      child: Text( 'Curso',style: TextStyle(fontSize: 25),)
                  ),
                  Positioned(
                      top: 110,
                      left: 160,
                      child: Text( 'Email',style: TextStyle(fontSize: 25),)
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black,style: BorderStyle.solid,width: 2)),
              margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
              width: 400,
              height: 160,

              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 20,
                      left: 10,
                      child: Image.asset(
                        "assets/image/pc1.png",
                      )
                  ),
                  Positioned(
                      top: 60,
                      left: 160,
                      child: Text('Num dispositivo',style: TextStyle(fontSize: 25),)
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }



}
