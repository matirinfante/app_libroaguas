import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:app_libroaguas/IncidenteFlujo.dart';

class Index extends StatefulWidget {
  _IndexState createState() => new _IndexState();
}

class _IndexState extends State<Index> {
  PageController _pageController = PageController(initialPage: 0);
  int _page = 0;
  GlobalKey _bottomBar = GlobalKey();

  Widget build(BuildContext context) {
    var _pageNames = {0: 'Inicio', 1: 'Incidente', 2: 'Registros'};
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(_pageNames[_page]),
        automaticallyImplyLeading: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[Index(), Incidente(), Registro()],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        color: Colors.deepOrange,
        key: _bottomBar,
        index: 0,
        height: 60,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.local_hospital, size: 30),
          Icon(Icons.event_note, size: 30)
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
          _pageController.animateToPage(
            _page,
            duration: Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut,
          );
        },
      ),
    );
  }

  Widget Index() {
    //TODO: debe obtener la informacion del guardavidas de la BD de guardavidas y hacer los datos persistentes
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              'Guardavidas: David Arregui',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text(
            'DNI: 37321651',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget Incidente() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: MaterialButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 50,
                    ),
                    Text(
                      'Rescate',
                      textScaleFactor: 0.8,
                      style: TextStyle(fontSize: 40),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Rescate()));
                },
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Expanded(
                child: MaterialButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 50,
                  ),
                  Text(
                    'Primeros Auxilios',
                    textScaleFactor: 0.8,
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
              onPressed: () {},
            )),
          ],
        ),
      ),
    );
  }

  Widget Registro() {
    return TabBarView(
      controller: TabController(),
      children: <Widget>[
        RegistroIncidentes(),
        RegistroPrevenciones(),
      ],
    );
  }

  //TODO: Implementar GET registros
  Widget RegistroIncidentes() {
    return Expanded(
        child: FutureBuilder<List<Incidente>>(
            future: Registro.db.getIncidentes(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Incidente>> snap) {
              if (snap.hasData) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snap.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Incidente item = snapshot.data[index];
                      return ListTile();
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget RegistroPrevenciones() {
    return Expanded(
        child: FutureBuilder<List<Prevencion>>(
            future: Registro.db.getPrevenciones(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Prevencion>> snap) {
              if (snap.hasData) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snap.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Prevencion item = snap.data[index];
                      return ListTile();
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
