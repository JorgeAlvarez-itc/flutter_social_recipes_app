import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categoria;
  String? urlFoto;

  CategoryModel({this.categoria, this.urlFoto});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoria: map['categoria'],
      urlFoto: map['urlFoto'],
    );
  }

  factory CategoryModel.fromQuerySnapshot(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return CategoryModel(
      categoria: data['categoria'],
      urlFoto: data['urlFoto'],
    );
  }

}
