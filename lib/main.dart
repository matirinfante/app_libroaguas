import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_libroaguas/Index.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new MaterialApp(
      title: 'Libro de Aguas',
      theme: new ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
      home: new LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/*Widget que contiene toda la screen de login, incluyendo un PageView con dos paginas, HomePage() y LoginPage().*/
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  /* Widget que contiene la vista principal. Incluye nombre de la app y un botón que habilita a LoginPage() */
  Widget HomePage() {
    return new Container(
        //Se decora to-do el contenedor
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.1), BlendMode.dstATop),
            image: AssetImage('images/img1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        //Se agrupan los siguientes widgets en una columna.
        child: Stack(
          children: <Widget>[
            IgnorePointer(
                child: CarouselSlider(
              viewportFraction: 1.0,
              height: MediaQuery.of(context).size.height,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              items: [1, 2, 3, 4].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop),
                          image: AssetImage('images/img$i.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            )),
            Column(children: <Widget>[
              //Icono
              Container(
                padding: EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Icon(
                    Icons.local_library,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
              //Texto
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LibroDe",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "Aguas",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              //Boton ENTRAR
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
                alignment: Alignment.center,
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                  alignment: Alignment.center,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.white,
                          onPressed: () => moverLogin(),
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 20.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "ENTRAR",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])
          ],
        ));
  }

  /* Widget que contiene la vista del login. Incluye un icono simple, campos de texto para E-mail y contraseña, validación de los mismos y un botón para ingresar. */
  Widget LoginPage() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('images/img5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(75.0),
              child: Center(
                child: Icon(
                  Icons.account_circle,
                  color: Colors.lightBlueAccent,
                  size: 50.0,
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.left,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
                        border: InputBorder.none,
                        hintText: 'Ingrese su e-mail',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 0.5,
                      style: BorderStyle.solid),
                ),
              ),
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: InputBorder.none,
                        hintText: 'Ingrese su contraseña',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              padding: EdgeInsets.only(top: 30.0),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.lightBlueAccent[700],
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Index()));
                      },
                      child: new Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Expanded(
                              child: Text(
                                "Ingresar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Funcion usada en el onTap() del botón de HomePage() encargada de animar y pasar a LoginPage()*/
  moverLogin() {
    _controller.animateToPage(
      1,
      duration: Duration(milliseconds: 800),
      curve: Curves.linearToEaseOut,
    );
  }

  /*Controlador de Paginas usado en el swipe down/up y botón de HomePage()*/
  PageController _controller =
      new PageController(initialPage: 0, viewportFraction: 1.0);

  /*Widget principal encargado de armar un PageView con HomePage() y LoginPage()*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: _controller,
            physics: new AlwaysScrollableScrollPhysics(),
            children: <Widget>[HomePage(), LoginPage()],
            scrollDirection: Axis.vertical,
          )),
    );
  }
}
