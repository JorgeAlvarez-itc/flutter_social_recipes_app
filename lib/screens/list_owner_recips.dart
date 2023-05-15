import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/models/recipe_model.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/widgets/recipe_widget.dart';
import 'package:recetas/widgets/loading_widget.dart';
import 'package:recetas/widgets/card_recipe_widget.dart';

class ListOwnRecipes extends StatelessWidget {
  const ListOwnRecipes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserCredential userCredential = args['user'] as UserCredential;
    DatabaseFirebase _dbReci = DatabaseFirebase(0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My recipes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Handle create icon pressed
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _dbReci.getOwnRecipes(userCredential.user!.uid.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  RecipeModel aux =
                      RecipeModel.fromQuerySnapshot(snapshot.data!.docs[index]);
                  return RecipeWidget(
                    recipeModel: aux,
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage(
                          'https://previews.123rf.com/images/gmast3r/gmast3r1706/gmast3r170600303/79721221-dibujos-animados-triste-cara-negativa-personas-emoci%C3%B3n-icono-vector-ilustraci%C3%B3n.jpg'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Aun no has publicado alguna receta",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ],
                ),
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error al realizar la peticion xd'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
