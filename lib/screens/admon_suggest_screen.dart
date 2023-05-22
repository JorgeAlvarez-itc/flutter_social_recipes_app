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
        centerTitle: true,
        title: Text(
          'Selecciona las categorias que son de tu agrado',
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
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
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                children: categorias.data!.map((categoria) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            categoria.urlFoto.toString(),
                            height: 120,
                            //width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              categoria.categoria.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Switch(
                            value: aux.categorias!.contains(categoria.id),
                            onChanged: (value) {
                              if (value) {
                                aux.categorias!.add(categoria.id!);
                              } else {
                                aux.categorias!.remove(categoria.id!);
                              }
                              _dbSuggest.updateDocument(
                                  aux.toMap(), snapshot.data!.docs[0].id);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
