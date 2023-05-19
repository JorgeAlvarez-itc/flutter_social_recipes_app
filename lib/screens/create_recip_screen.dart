import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/models/recipe_model.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:recetas/widgets/loading_widget.dart';
import 'package:recetas/firebase/firebase_storage.dart';
import 'package:recetas/widgets/awesomeDialog_widget.dart';
import 'package:recetas/controllers/general_controller.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class CreateRecipScreen extends StatefulWidget {
  @override
  State<CreateRecipScreen> createState() => _CreateRecipScreenState();
}

class _CreateRecipScreenState extends State<CreateRecipScreen> {
  final _database = DatabaseFirebase(1);
  final _databaseRecips = DatabaseFirebase(0);
  final FireStorage _storage = FireStorage();
  final _formKey = GlobalKey<FormState>();
  final GeneralController generalController = Get.put(GeneralController());
  int contador = 0;
  RecipeModel? recipeModel;
  String? recipeID;
  Awesome awesome = Awesome();
  List<DropdownMenuItem<String>> categoriaItems = [];

  TextEditingController? txtNombre = TextEditingController();
  TextEditingController? txtuid = TextEditingController();
  TextEditingController? txtCat = TextEditingController();
  TextEditingController? txtTiempo = TextEditingController();
  TextEditingController? txtCosto = TextEditingController();
  TextEditingController? txtCalorias = TextEditingController();
  TextEditingController? txtIngredientes = TextEditingController();
  TextEditingController? txtProcedimiento = TextEditingController();
  TextEditingController? txtFoto = TextEditingController();
  TextEditingController? txtVideo = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategorias();
  }

  Future<void> _loadCategorias() async {
    final snapshot = await _database.getAllDocuments().first;
    final categorias = snapshot.docs;
    categoriaItems = categorias.map((doc) {
      final id = doc.id;
      generalController.categoriaValue.value = id;
      final data = doc.data() as Map<String, dynamic>;
      final nombre = data['categoria'];
      return DropdownMenuItem<String>(
        value: id,
        child: Text(nombre),
      );
    }).toList();
  }

  void _openGallery(BuildContext context) async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    generalController.updateImage(File(pickedImage!.path));
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    generalController.updateImage(File(pickedImage!.path));
    Navigator.of(context).pop();
  }

  Future<bool> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String? uriAux = '';
      List<String> procedimientoList = txtProcedimiento!.text.split('\n');
      List<String> ingredientesList = txtIngredientes!.text.split('\n');
      if (generalController.isImage.value != null) {
        await _storage
            .uploadFile(generalController.isImage.value!,
                txtuid!.text + txtNombre!.text)
            .then((value) {
          if (value != null) {
            uriAux = value;
          } else {
            uriAux = null;
          }
        });
      }
      if (uriAux != null) {
        RecipeModel recipeModelAux = RecipeModel(
            nombre: txtNombre!.text,
            tiempo: txtTiempo!.text,
            costo: txtCosto!.text,
            calorias: int.parse(txtCalorias!.text.toString()),
            ingredientes: ingredientesList,
            procedimiento: procedimientoList,
            foto: uriAux!.length > 0 ? uriAux : recipeModel!.foto!,
            video: txtVideo!.text.isNotEmpty ? txtVideo!.text : '',
            calificacion: 0.0,
            idCategoria: txtCat!.text,
            idUsuario: txtuid!.text,
            voteCount: recipeModel!=null?recipeModel!.voteCount :0);
        if (recipeModel != null) {
          _databaseRecips.updateDocument(recipeModelAux.toMap(), recipeID!);
        } else {
          _databaseRecips.insertDocument(recipeModelAux.toMap());
        }
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    generalController.isImage.value != null;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserCredential userCredential = args['user'] as UserCredential;
    txtuid!.text = userCredential.user!.uid.toString();
    recipeModel = args['recipe'] != null ? args['recipe'] as RecipeModel : null;
    recipeID = args['id'] != null ? args['id'] as String : null;

    if (recipeModel != null && contador < 1) {
      txtNombre!.text = recipeModel!.nombre!;
      txtuid!.text = recipeModel!.idUsuario!;
      txtCat!.text = recipeModel!.idCategoria!;
      txtTiempo!.text = recipeModel!.tiempo!;
      txtCosto!.text = recipeModel!.costo!;
      txtCalorias!.text = recipeModel!.calorias!.toString();
      txtIngredientes!.text = recipeModel!.ingredientes!.join('\n');
      txtProcedimiento!.text = recipeModel!.procedimiento!.join('\n');
      txtFoto!.text = recipeModel!.foto!;
      txtVideo!.text = recipeModel!.video!;
    }
    contador++;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            generalController.isImage!.value = null;
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          recipeModel != null ? 'Modificar receta' : 'Crear receta',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        if (generalController.isImage.value != null) {
                          return Image(
                            image: FileImage(generalController.isImage.value!),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height / 5,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return LoadingWidget();
                              }
                            },
                          );
                        } else {
                          return Image(
                            image: NetworkImage(recipeModel != null
                                ? recipeModel!.foto!
                                : 'https://img.freepik.com/foto-gratis/resumen-superficie-texturas-muro-piedra-hormigon-blanco_74190-8189.jpg'),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height / 5,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return LoadingWidget();
                              }
                            },
                          );
                        }
                      }),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Container(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text('Galeria'),
                                      onTap: () {
                                        _openGallery(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera),
                                      title: Text('Camara'),
                                      onTap: () {
                                        _openCamera(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                      ),
                                      title: Text('Cancel'),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.photo_library,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Crear receta',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: txtNombre,
                            decoration: InputDecoration(
                              labelText: 'Nombre de la receta',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el nombre de la receta';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            controller: txtTiempo,
                            decoration: InputDecoration(
                              labelText: 'Tiempo de preparación',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el tiempo de preparación';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: txtCosto,
                            decoration: InputDecoration(
                              labelText: 'Costo',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el costo';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            controller: txtCalorias,
                            decoration: InputDecoration(
                              labelText: 'Calorías',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa las calorías';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: txtVideo,
                            decoration: InputDecoration(
                              labelText: 'URL Video',
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Obx(() => DropdownButtonFormField<String>(
                                value: generalController.categoriaValue.value,
                                onChanged: (value) {
                                  txtCat!.text = value!;
                                  generalController.categoriaValue.value =
                                      value;
                                },
                                items: categoriaItems,
                                decoration: InputDecoration(
                                  labelText: 'Categoría',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, selecciona una categoría';
                                  }
                                  return null;
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: txtIngredientes,
                  decoration: InputDecoration(
                    labelText: 'Ingredientes (Un ingrediente por linea)',
                  ),
                  maxLines: null, // Permite ingresar múltiples líneas
                  keyboardType: TextInputType
                      .multiline, // Habilita el teclado de múltiples líneas
                  textInputAction: TextInputAction
                      .newline, // Cambia el botón de acción del teclado a "Enter"
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa los ingredientes';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: txtProcedimiento,
                  decoration: InputDecoration(
                    labelText: 'Procedimiento (Un paso por linea)',
                  ),
                  maxLines: null, // Permite ingresar múltiples líneas
                  keyboardType: TextInputType
                      .multiline, // Habilita el teclado de múltiples líneas
                  textInputAction: TextInputAction
                      .newline, // Cambia el botón de acción del teclado a "Enter"
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el procedimiento';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: SocialLoginButton(
                    buttonType: SocialLoginButtonType.generalLogin,
                    onPressed: () async {
                      if (await _submitForm()) {
                        generalController.isImage!.value = null;
                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                title: 'Receta publicada con éxito',
                                desc:
                                    'Su receta se ha publicado con éxito en la red',
                                btnOkOnPress: () {
                                  Navigator.pop(context);
                                },
                                animType: AnimType.scale)
                            .show();
                      } else {
                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                title: 'Ocurrió un error al publicar la receta',
                                desc: 'Por favor contacte a soporte',
                                btnOkColor: Colors.redAccent,
                                btnOkOnPress: () {},
                                animType: AnimType.scale)
                            .show();
                      }
                    },
                    text: 'Publicar receta',
                    backgroundColor: Colors.orangeAccent,
                    borderRadius: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
