import 'package:flutter/cupertino.dart';

class utilText extends StatefulWidget {
  String texto="";


    utilText(this.texto,{Key? key}) : super(key: key);

  @override
  State<utilText> createState() => _utilTextState(this.texto);
}

class _utilTextState extends State<utilText> {
  String texto="";


  _utilTextState(this.texto);
  @override
  Widget build(BuildContext context) {
    return Text(
      texto ,
      style: TextStyle(fontSize: 25),
    );
  }
}
