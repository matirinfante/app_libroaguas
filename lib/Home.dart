import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Index'),
      ),
      body: Contenedor(),
    );
  }
}

class Contenedor extends StatefulWidget {
  _ContenedorState createState() => _ContenedorState();
}

class _ContenedorState extends State<Contenedor> {
  PageController _controlador = new PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controlador,
      children: <Widget>[],
    );
  }
}
