import 'package:flutter/material.dart';
import 'package:recetas/models/favs_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/models/recipe_model.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:recetas/widgets/recipe_widget.dart';
import 'package:recetas/widgets/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavScreen extends StatelessWidget {
  FavScreen({super.key});
  DatabaseFirebase _firebaseFavs = DatabaseFirebase(2);
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserCredential userCredential = args['user'] as UserCredential;
    print(args);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Recetas favoritas',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _firebaseFavs.getFavoriteRecipes(userCredential.user!.uid),
        builder: (context, snapshot) {
          FavsModel? favsModel;
          if (snapshot.hasData) {
            favsModel = FavsModel.fromQuerySnapshot(snapshot.data!.docs[0]);
          }

          return FutureBuilder(
            future: _firebaseFavs.getRecipesFromIds(favsModel!.recetas!),
            builder: (context, snapshot1) {
              if (snapshot1.hasData) {
                return ListView.builder(
                  itemCount: snapshot1!.data!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: RecipeWidget(
                            recipeModel: snapshot1.data![index],
                            docId: snapshot1.data![index].id,
                            userCredential: userCredential,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            color: Colors.red,
                            onPressed: () {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.infoReverse,
                                  title: 'Confirmar',
                                  desc:
                                      '¿Desea eliminar esta receta de sus favoritos?',
                                  animType: AnimType.bottomSlide,
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    print(snapshot1.data![index].id);
                                    snapshot1.data!.removeAt(index);
                                    List<String> recipeIds = snapshot1.data
                                            ?.map((recipe) => recipe.id ?? '')
                                            .toList() ??
                                        [];
                                    _firebaseFavs.updateDocument({
                                      'idUsuario': userCredential.user!.uid,
                                      'recetas': recipeIds
                                    }, snapshot.data!.docs[0].id);
                                  }).show();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot1.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://img.icons8.com/?size=512&id=2ktEoAjSYwq4&format=png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Aún no has agregado recetas a favoritos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
