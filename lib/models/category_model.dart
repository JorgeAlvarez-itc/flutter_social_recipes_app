class CategoryModel {
  int? idCategoria;
  String? categoria;
  String? urlFoto;

  CategoryModel({this.idCategoria, this.categoria, this.urlFoto});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      idCategoria: map['id_categoria'],
      categoria: map['categoria'],
      urlFoto: map['url_foto'],
    );
  }

  CategoryModel.fromJson(Map<String, dynamic> json) {
    idCategoria = json['id_categoria'];
    categoria = json['categoria'];
    urlFoto = json['url_foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_categoria'] = this.idCategoria;
    data['categoria'] = this.categoria;
    data['url_foto'] = this.urlFoto;
    return data;
  }
}
