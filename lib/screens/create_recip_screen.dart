import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/widgets/awesomeDialog_widget.dart';
import 'package:recetas/controllers/general_controller.dart';

class CreateRecipScreen extends StatefulWidget {
  @override
  State<CreateRecipScreen> createState() => _CreateRecipScreenState();
}

class _CreateRecipScreenState extends State<CreateRecipScreen> {
  final _database = DatabaseFirebase(1); 
  final _formKey = GlobalKey<FormState>();
  final GeneralController generalController = Get.put(GeneralController());
  Awesome awesome = Awesome();
  List<DropdownMenuItem<String>> categoriaItems = [];

  TextEditingController? txtNombre = TextEditingController();
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

  void _submitForm(){
     if (_formKey.currentState!.validate()) {
       
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicar receta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage('assets/images/your_image.jpg'),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 5,
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
                TextFormField(
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
                SizedBox(height: 10.0),
                // Resto de los TextFormField para los demás campos del formulario
                // ...
                SizedBox(height: 10.0),
                Obx(() => DropdownButtonFormField<String>(
                      value: generalController.categoriaValue.value,
                      onChanged: (value) {
                        txtCat!.text=value!;
                        generalController.categoriaValue.value = value!;
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
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                   
                  },
                  child: Text('Guardar receta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
