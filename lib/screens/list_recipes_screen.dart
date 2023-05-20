import '../models/recipe_model.dart';
import '../firebase/firebase_db.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/widgets/recipe_widget.dart';
import 'package:recetas/widgets/card_recipe_widget.dart';

class ListAllrecipes extends StatelessWidget {
  ListAllrecipes({super.key});
  String? idCat;
  @override
  Widget build(BuildContext context) {
    DatabaseFirebase _dbReci = DatabaseFirebase(0);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserCredential userCredential = args['user'] as UserCredential;
    if (args['idCat'] != null) {
      idCat = args['idCat'] as String;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Recetas',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: idCat != null
                ? _dbReci.getAllRecipesByCat(idCat!)
                : _dbReci.getAllDocuments(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return OrientationBuilder(
                  builder: (context, orientation) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            orientation == Orientation.landscape ? 2 : 1,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio:
                            orientation == Orientation.landscape ? 2.3 : 2.1,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        RecipeModel aux = RecipeModel.fromQuerySnapshot(
                            snapshot.data!.docs[index]);
                        return RecipeWidget(
                          recipeModel: aux,
                          docId: aux.id,
                          userCredential: userCredential,
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error al realizar la petición'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
