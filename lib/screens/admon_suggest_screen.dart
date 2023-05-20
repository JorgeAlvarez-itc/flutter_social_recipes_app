import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/models/suggest_model.dart';
import 'package:recetas/widgets/loading_widget.dart';

class AdmonSuggestScreen extends StatelessWidget {
  AdmonSuggestScreen({Key? key});
  final DatabaseFirebase _dbSuggest = DatabaseFirebase(3);
  final DatabaseFirebase _dbCat = DatabaseFirebase(1);
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserCredential userCredential = args['user'] as UserCredential;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Selecciona las categorias que son de tu agrado',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: _dbSuggest.getSuggestCategories(userCredential.user!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget(); // Reemplaza LoadingWidget con el widget de carga que desees mostrar
          }
          if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Reemplaza con el manejo de error que desees mostrar
          }
          SuggestModel aux =
              SuggestModel.fromQuerySnapshot(snapshot.data!.docs[0]);
          return FutureBuilder(
            future: _dbCat.getAllCategories(),
            builder: (context, categorias) {
              if (categorias.connectionState == ConnectionState.waiting) {
                return LoadingWidget(); // Reemplaza LoadingWidget con el widget de carga que desees mostrar
              }
              if (categorias.hasError) {
                return Text(
                    'Error: ${categorias.error}'); // Reemplaza con el manejo de error que desees mostrar
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: categorias.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(categorias.data![index].categoria!),
                          trailing: Checkbox(
                            value: aux.categorias!
                                .contains(categorias.data![index].id),
                            onChanged: (value) {
                              if (value!) {
                                aux.categorias!
                                    .add(categorias.data![index].id!);
                              } else {
                                aux.categorias!
                                    .remove(categorias.data![index].id!);
                              }
                              _dbSuggest.updateDocument(
                                  aux.toMap(), snapshot.data!.docs[0].id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
