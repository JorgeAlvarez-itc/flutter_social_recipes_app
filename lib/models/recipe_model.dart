import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeModel {
  String? nombre;
  String? tiempo;
  String? costo;
  int? calorias;
  List<String>? ingredientes;
  List<String>? procedimiento;
  String? foto;
  String? video;
  double? calificacion;
  String? idUsuario;
  String? idCategoria;

  RecipeModel(
      {this.nombre,
      this.tiempo,
      this.costo,
      this.calorias,
      this.ingredientes,
      this.procedimiento,
      this.foto,
      this.video,
      this.calificacion,
      this.idUsuario,
      this.idCategoria});

  factory RecipeModel.fromQuerySnapshot(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    print(data);
    return RecipeModel(
      nombre: data['nombre'],
      tiempo: data['tiempo'],
      costo: data['costo'].toString(),
      calorias: int.parse(data['calorias'].toString()),
      ingredientes: List<String>.from(data['ingredientes']),
      procedimiento: List<String>.from(data['procedimiento']),
      foto: data['foto'],
      video: data['video'],
      calificacion: double.parse(data['calificacion'].toString()),
      idUsuario: data['idUsuario'],
      idCategoria: data['idCategoria'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'tiempo': tiempo,
      'costo': costo,
      'calorias': calorias,
      'ingredientes': ingredientes,
      'procedimiento': procedimiento,
      'foto': foto,
      'video': video,
      'calificacion': calificacion,
      'idUsuario': idUsuario,
      'idCategoria': idCategoria,
    };
  }
}
