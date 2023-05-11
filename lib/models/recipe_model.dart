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
  int? idCategoria;

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

  RecipeModel.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    tiempo = json['tiempo'];
    costo = json['costo'];
    calorias = json['calorias'];
    ingredientes = json['ingredientes'].cast<String>();
    procedimiento = json['procedimiento'].cast<String>();
    foto = json['foto'];
    video = json['video'];
    calificacion = json['calificacion'];
    idUsuario = json['id_usuario'];
    idCategoria = json['id_categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['tiempo'] = this.tiempo;
    data['costo'] = this.costo;
    data['calorias'] = this.calorias;
    data['ingredientes'] = this.ingredientes;
    data['procedimiento'] = this.procedimiento;
    data['foto'] = this.foto;
    data['video'] = this.video;
    data['calificacion'] = this.calificacion;
    data['id_usuario'] = this.idUsuario;
    data['id_categoria'] = this.idCategoria;
    return data;
  }
}
