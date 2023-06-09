import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/home_controller.dart';
import 'package:recetas/models/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/models/suggest_model.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/models/category_model.dart';
import 'package:recetas/widgets/recipe_widget.dart';
import 'package:recetas/widgets/loading_widget.dart';
import 'package:recetas/settings/theme_settings.dart';
import 'package:recetas/widgets/categories_widget.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final isEmailAccount = args['isEmailAccount'] ?? false;
    final UserCredential userCredential = args['user'] as UserCredential;
    DatabaseFirebase _dbCat = DatabaseFirebase(1);
    DatabaseFirebase _dbReci = DatabaseFirebase(0);
    DatabaseFirebase _dbSuggest = DatabaseFirebase(3);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(imageUrl: 
                'https://images.pexels.com/photos/616838/pexels-photo-616838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Hola!',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            userCredential.user!.providerData[0].displayName
                                .toString()
                                .split(' ')[0],
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(0.6),
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Receta especial hoy:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        FutureBuilder(
                          future: _dbReci.getRecipeWithHighestRating(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return LoadingWidget();
                            } else if (snapshot.hasError) {
                              return LoadingWidget();
                            } else {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/details',
                                        arguments: {
                                          'recipe': snapshot.data,
                                          'id': snapshot.data!.id,
                                          'user': userCredential,
                                        });
                                  },
                                  child: CachedNetworkImage(imageUrl: 
                                    snapshot.data!.foto!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: StreamBuilder(
              stream: _dbCat.getAllDocuments(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      CategoryModel aux = CategoryModel.fromQuerySnapshot(
                          snapshot.data!.docs[index]);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryWidget(
                          categoryModel: aux,
                          userCredential: userCredential,
                        ),
                      );
                    },
                  );
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
          ),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sugerencias',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/listall',
                        arguments: {'user': userCredential});
                  },
                  child: const Text(
                    'Ver todo!',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 165,
                    child: StreamBuilder(
                        stream: _dbSuggest
                            .getSuggestCategories(userCredential.user!.uid),
                        builder: (context, snapshot) {
                          SuggestModel aux = SuggestModel.fromQuerySnapshot(
                              snapshot.data!.docs[0]);
                          if (snapshot.hasData) {
                            return FutureBuilder(
                              future: aux.categorias!.isNotEmpty
                                  ? _dbReci.getAllRecipSuggest(aux.categorias)
                                  : _dbReci.getAllRecipes(),
                              builder: (context, recetas) {
                                if (recetas.hasError) {
                                  return const LoadingWidget();
                                } else if (recetas.connectionState ==
                                    ConnectionState.waiting) {
                                  return const LoadingWidget();
                                }
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recetas.data!.length,
                                  itemBuilder: (context, index) {
                                    RecipeModel aux = recetas.data![index];
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
                              child: Text('Error al realizar la peticion xd'),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
