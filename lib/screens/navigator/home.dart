import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/home_controller.dart';
import 'package:recetas/models/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/models/category_model.dart';
import 'package:recetas/widgets/recipe_widget.dart';
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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                'https://images.pexels.com/photos/616838/pexels-photo-616838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Hello',
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
                        Text(
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
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/search');
                        },
                        icon: Icon(Icons.search),
                      ),
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
                              'SPECIAL RECIPE TODAY',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            'https://images.pexels.com/photos/4146123/pexels-photo-4146123.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(color: Colors.orangeAccent),
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
            color: Colors.white,
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
                  onPressed: () {},
                  child: const Text(
                    'See All',
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
                    height: 150,
                    child: StreamBuilder(
                        stream: _dbReci.getAllDocuments(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                RecipeModel aux = RecipeModel.fromQuerySnapshot(
                                    snapshot.data!.docs[index]);
                                return RecipeWidget(
                                  recipeModel: aux,
                                  docId: snapshot!.data!.docs[index].id,
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
