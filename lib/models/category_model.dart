import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoria;
  String? urlFoto;
  String? id;

  CategoryModel({this.categoria, this.urlFoto, this.id});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoria: map['categoria'],
      urlFoto: map['urlFoto'],
      id: map['id'],
    );
  }

  factory CategoryModel.fromQuerySnapshot(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return CategoryModel(
      categoria: data['categoria'],
      urlFoto: data['urlFoto'],
      id: document.id,
    );
  }

}
