import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/widgets/categories_widget.dart';
import 'package:recetas/controllers/general_controller.dart';

class AdmonSuggestScreen extends StatelessWidget {
  AdmonSuggestScreen({Key? key});
  final GeneralController generalController = Get.put(GeneralController());
  @override
  Widget build(BuildContext context) {
    final DatabaseFirebase _dbCat = DatabaseFirebase(0);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserCredential userCredential = args['user'] as UserCredential;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sugerencias', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _dbCat.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar las categorías'),
            );
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelected = generalController.isLoading.value;
                  return GestureDetector(
                    onTap: () {
                      generalController.changeLoadingView();
                    },
                    child: Container(
                      // Personaliza el estilo del container según tus necesidades
                      color: isSelected ? Colors.orangeAccent : Colors.white,
                      child: CategoryWidget(
                          categoryModel: snapshot.data![index],
                          userCredential: userCredential),
                    ),
                  );
                }); // Aquí debes definir la lógica para determinar si la categoría está seleccionada o no
              },
            );
          } else {
            return Center(
              child: Text('No hay categorías disponibles'),
            );
          }
        },
      ),
    );
  }
}
