class RecipeModel {
  int? idReceta;
  String? titulo;
  List<String>? ingredientes;
  List<String>? preparacion;
  String? idUsuario;
  int? costo;
  String? urlFoto;
  String? urlVideo;
  double? votacion;

  RecipeModel(
      {this.idReceta,
      this.titulo,
      this.ingredientes,
      this.preparacion,
      this.idUsuario,
      this.costo,
      this.urlFoto,
      this.urlVideo,
      this.votacion});

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      idReceta: map['id_receta'],
      titulo: map['titulo'],
      ingredientes: List<String>.from(map['ingredientes']),
      preparacion: List<String>.from(map['preparacion']),
      idUsuario: map['id_usuario'],
      costo: map['costo'],
      urlFoto: map['url_foto'],
      urlVideo: map['url_video'],
      votacion: map['votacion'],
    );
  }

  RecipeModel.fromJson(Map<String, dynamic> json) {
    idReceta = json['id_receta'];
    titulo = json['titulo'];
    ingredientes = json['ingredientes'].cast<String>();
    preparacion = json['preparacion'].cast<String>();
    idUsuario = json['id_usuario'];
    costo = json['costo'];
    urlFoto = json['url_foto'];
    urlVideo = json['url_video'];
    votacion = json['votacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_receta'] = this.idReceta;
    data['titulo'] = this.titulo;
    data['ingredientes'] = this.ingredientes;
    data['preparacion'] = this.preparacion;
    data['id_usuario'] = this.idUsuario;
    data['costo'] = this.costo;
    data['url_foto'] = this.urlFoto;
    data['url_video'] = this.urlVideo;
    data['votacion'] = this.votacion;
    return data;
  }
}