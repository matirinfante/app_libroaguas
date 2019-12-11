class Prevencion {
  //TODO: ESTAN BIEN????????????????????
  DateTime fecha;
  int cantidadPersonas, edad;
  String sector;

  Prevencion({this.fecha, this.cantidadPersonas, this.sector, this.edad});

  Map<String, dynamic> toMap() => {
        "fechaRegistro": fecha,
        "cantidadPersonas": cantidadPersonas,
        "sector": sector,
        "edad": edad
      };

  factory Prevencion.fromMap(Map<String, dynamic> json) => new Prevencion(
      fecha: json["fechaRegistro"],
      cantidadPersonas: json["cantidadPersonas"],
      sector: json["sector"],
      edad: json["edad"]);
}
