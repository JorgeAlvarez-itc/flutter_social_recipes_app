import 'package:cloud_firestore/cloud_firestore.dart';

class FavsModel {
  String? idUsuario;
  List<String>? recetas;

  FavsModel({this.idUsuario, this.recetas});

  factory FavsModel.fromMap(Map<String, dynamic> map) {
    return FavsModel(
      idUsuario: map['idUsuario'],
      recetas:List<String>.from(map['recetas']),
    );
  }

  factory FavsModel.fromQuerySnapshot(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return FavsModel(
      idUsuario: data['idUsuario'],
      recetas: List<String>.from(data['recetas']),
    );
  }

}
