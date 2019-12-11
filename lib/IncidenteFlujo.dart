import 'package:flutter/material.dart';

import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:custom_radio/custom_radio.dart';

class Rescate extends StatefulWidget {
  String tipoRescate = '', charGenero = '';
  List<bool> datos = new List(5);
  int grupoEtario = -1, genero = -1;
  bool procedencia;

  //[ esLocal, huboRCP, huboTraumatismo, huboEnfermeria, huboHospital ]
  @override
  _RescateState createState() => _RescateState();
}

class _RescateState extends State<Rescate> {
  PageController _pageController = PageController(initialPage: 0);

  List<RadioModel> datosAsistencia = new List<RadioModel>();
  var _pageNames;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    datosAsistencia
        .add(new RadioModel(false, Icons.done_outline, 'RCP', false));
    datosAsistencia
        .add(new RadioModel(false, Icons.done_outline, 'Traumatismo', false));
    datosAsistencia.add(new RadioModel(
        false, Icons.done_outline, 'Derivación a Enfermería', false));
    datosAsistencia.add(new RadioModel(
        false, Icons.done_outline, 'Derivación a Hospital', false));
  }

  @override
  Widget build(BuildContext context) {
    _pageNames = {
      0: 'Seleccione tipo de rescate',
      1: 'Datos adicionales',
      2: 'Datos de la Victima',
      3: 'Resumen'
    };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Rescate',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          TipoRescate(),
          DatosAsistencia(),
          DatosVictima(),
          Resumen()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              heroTag: 'back',
              child: Icon(Icons.navigate_before),
              onPressed: () {
                _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, right: 20.0),
            child: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                heroTag: 'next',
                child: Icon(Icons.navigate_next),
                onPressed: () {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }),
          ),
        ],
      ),
    );
  }

  Widget DatosAsistencia() {
    return Container(
      child: Center(
          child: Stack(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Seleccione todos los campos necesarios',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Container(
            child: ListView.builder(
                itemCount: datosAsistencia.length,
                itemBuilder: (BuildContext context, int index) {
                  return new InkWell(
                    //highlightColor: Colors.red,
                    splashColor: Colors.grey[300],
                    onTap: () {
                      setState(() {
                        datosAsistencia[index].isSelected =
                            !datosAsistencia[index].isSelected;
                        widget.datos[index] = datosAsistencia[index].isSelected;
                      });
                    },
                    child: new RadioItem(datosAsistencia[index]),
                  );
                }),
          ),
        ),
      ])),
    );
  }

  Widget DatosVictima() {
    void _cambiarGenero(int genero) {
      setState(() {
        widget.genero = genero;
      });
    }

    void _cambiarEdad(int edad) {
      setState(() {
        widget.grupoEtario = edad;
      });
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.black.withOpacity(.3),
                        offset: Offset(6.0, 7.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Grupo etario',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                  value: 0,
                                  groupValue: widget.grupoEtario,
                                  onChanged: _cambiarEdad),
                              Text('Niño')
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: widget.grupoEtario,
                                onChanged: _cambiarEdad,
                              ),
                              Text('Adolescente')
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                  value: 2,
                                  groupValue: widget.grupoEtario,
                                  onChanged: _cambiarEdad),
                              Text('Adulto')
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      color: Colors.black.withOpacity(.3),
                      offset: Offset(6.0, 7.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Género',
                      style: TextStyle(fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Radio(
                              value: 0,
                              groupValue: widget.genero,
                              onChanged: _cambiarGenero),
                          Text('Femenino')
                        ]),
                        Row(
                          children: <Widget>[
                            Radio(
                                value: 1,
                                groupValue: widget.genero,
                                onChanged: _cambiarGenero),
                            Text('Masculino')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                                value: 2,
                                groupValue: widget.genero,
                                onChanged: _cambiarGenero),
                            Text('Otro')
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.black.withOpacity(.3),
                        offset: Offset(6.0, 7.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Procedencia',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                  value: true,
                                  groupValue: widget.procedencia,
                                  onChanged: (valor) {
                                    setState(() {
                                      widget.procedencia = true;
                                    });
                                  }),
                              Text('Local')
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                  value: false,
                                  groupValue: widget.procedencia,
                                  onChanged: (valor) {
                                    setState(() {
                                      widget.procedencia = valor;
                                    });
                                  }),
                              Text('Turista')
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Resumen() {
    var gruposEdad = {-1: '', 0: 'Niño', 1: 'Adolescente', 2: 'Adulto'};
    var gruposGenero = {-1: '', 0: 'Femenino', 1: 'Masculino', 2: 'Otro'};
    var grupoProcedencia = {
      null: '',
      true: 'Procedencia local',
      false: 'Turista'
    };
    TextStyle titulos = new TextStyle(fontSize: 25);
    //datosAsistencia.forEach((elemento){elemento ? });

    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.tipoRescate,
                      textAlign: TextAlign.center,
                      style: titulos,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
                child: Text(
              'Se muestran los datos de asistencia adicionales...',
              textAlign: TextAlign.center,
              style: titulos,
            )),
            Divider(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      gruposEdad[widget.grupoEtario],
                      textAlign: TextAlign.center,
                      style: titulos,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        onPressed: () {})
                  ]),
            )),
            Divider(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    gruposGenero[widget.genero],
                    textAlign: TextAlign.center,
                    style: titulos,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      onPressed: () {})
                ],
              ),
            )),
            Divider(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    grupoProcedencia[widget.procedencia],
                    textAlign: TextAlign.center,
                    style: titulos,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      onPressed: () {})
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class RadioItem extends StatefulWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  _RadioItemState createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  var _circulo = 50.0, _cuadrado = 5.0;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
                child:
                    Icon(widget._item.isSelected ? widget._item.icon : null)),
            decoration: new BoxDecoration(
              color:
                  widget._item.isSelected ? Colors.green : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: widget._item.isSelected ? Colors.green : Colors.grey),
              borderRadius: BorderRadius.all(
                  Radius.circular(widget._item.radius ? _circulo : _cuadrado)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(widget._item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final IconData icon;
  final String text;
  final bool radius;

  RadioModel(this.isSelected, this.icon, this.text, this.radius);
}

class TipoRescate extends StatefulWidget {
  String tipoRescate;

  @override
  _TipoRescateState createState() => _TipoRescateState();
}

class _TipoRescateState extends State<TipoRescate> {
  List<RadioModel> tiposRescate = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    tiposRescate
        .add(new RadioModel(false, Icons.done_outline, 'Rescate Simple', true));
    tiposRescate.add(
        new RadioModel(false, Icons.done_outline, 'Rescate Complicado', true));
    tiposRescate.add(
        new RadioModel(false, Icons.done_outline, 'Rescate Múltiple', true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: ListView.builder(
            itemCount: tiposRescate.length,
            itemBuilder: (BuildContext context, int index) {
              return new InkWell(
                //highlightColor: Colors.red,
                splashColor: Colors.grey[300],
                onTap: () {
                  setState(() {
                    tiposRescate
                        .forEach((element) => element.isSelected = false);
                    tiposRescate[index].isSelected = true;
                    widget.tipoRescate = tiposRescate[index].text;
                  });
                },
                child: new RadioItem(tiposRescate[index]),
              );
            }),
      ),
    ));
  }
}
