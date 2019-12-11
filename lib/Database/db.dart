import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class RegistrosDB {
  RegistrosDB._();

  static final RegistrosDB db = RegistrosDB._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "pregunta.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Asistencia ("
          "idAsistencia integer primary key unique auto increment,"
          "idGuardavidas integer not null,"
          "Fecha text not null,"
          "idTipo integer not null,"
          "Lugar blob not null,"
          "Observacion text"
          ");"
          "CREATE TABLE Prevencion ("
          "idPrevencion integer primary key auto increment,"
          "idAsistencia not null,"
          "Peligro text not null,"
          "Comportamiento text not null"
          ");"
          "CREATE TABLE Incidente ("
          "idIncidente  integer primary key auto increment,"
          "idAsistencia integer not null,"
          "idComplejidad integer not null,"
          "idPrimerosAuxilios text not null"
          ");"
          "CREATE TABLE Victima ("
          "idVictima integer primary key auto increment,"
          "idGenero DATE not null,"
          "idRangoEtario integer not null,"
          "Cantidad integer not null,"
          "idProcedencia integer not null,"
          "idAsistencia integer not null,"
          ");");
    });
  }
//TODO: DAL completo
}
