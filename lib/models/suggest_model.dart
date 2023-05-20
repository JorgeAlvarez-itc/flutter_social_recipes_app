import 'package:cloud_firestore/cloud_firestore.dart';

class SuggestModel {
  String? idUsuario;
  List<String>? categorias;

  SuggestModel({this.idUsuario, this.categorias});

  factory SuggestModel.fromMap(Map<String, dynamic> map) {
    return SuggestModel(
      idUsuario: map['idUsuario'],
      categorias:List<String>.from(map['categorias']),
    );
  }

  factory SuggestModel.fromQuerySnapshot(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return SuggestModel(
      idUsuario: data['idUsuario'],
      categorias: List<String>.from(data['categorias']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'categorias': categorias,
    };
  }

}
