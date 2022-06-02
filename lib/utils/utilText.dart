import 'package:flutter/cupertino.dart';

class utilText extends StatefulWidget {
  String texto="";
  double fontSize=0;
  int number=0;
    utilText(this.texto,this.fontSize,this.number,{Key? key}) : super(key: key);

  @override
  State<utilText> createState() => _utilTextState(this.texto,this.fontSize,this.number);
}

class _utilTextState extends State<utilText> {
  String texto="";
  double fontSize=0;
  int number=0;
  _utilTextState(this.texto,this.fontSize,this.number);
  @override
  Widget build(BuildContext context) {
    return Text(
      texto +'($number)',
      style: TextStyle(fontSize: fontSize),
    );
  }
}
