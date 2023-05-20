import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:recetas/models/favs_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:recetas/models/recipe_model.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:recetas/responsive/responsive.dart';
import 'package:recetas/widgets/loading_widget.dart';

class DetailsRecipeScreen extends StatelessWidget {
  RecipeModel? recipe;
  String? id;
  DetailsRecipeScreen({Key? key, this.recipe}) : super(key: key);
  DatabaseFirebase _dbReci = DatabaseFirebase(0);
  DatabaseFirebase _dbFavs = DatabaseFirebase(2);
  FavsModel? favsModel;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    recipe = args['recipe'] as RecipeModel;
    id = args['id'] as String;
    final UserCredential userCredential = args['user'] as UserCredential;
    print(args);
    final _dialog = RatingDialog(
      initialRating: 0.0,
      // your app's name?
      title: const Text(
        'Calificar receta',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'Envía una calificación sobre esta receta: ${recipe!.nombre}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: Image.network(
        recipe?.foto ?? '',
      ),
      submitButtonText: 'Calificar',
      enableComment: false,
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) async {
        recipe!.calificacion =
            (recipe!.calificacion! * recipe!.voteCount! + response.rating) /
                (recipe!.voteCount! + 1);
        recipe!.voteCount = recipe!.voteCount! + 1;

        await _dbReci.updateDocument(recipe!.toMap(), id!);
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(recipe!.nombre!,
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Responsive(
            mobile: _buildMobileRecipe(context, _dialog, userCredential),
            tablet: _buildLanscapeRecipe(context, _dialog, userCredential),
            desktop: _buildLanscapeRecipe(context, _dialog, userCredential),
          )
        ],
      ),
    );
  }

  _buildMobileRecipe(BuildContext context, RatingDialog _dialog,
      UserCredential userCredential) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    recipe?.foto ?? '',
                    //width: double.infinity,
                    fit: BoxFit.fill,
                    height: 350,
                    width: MediaQuery.of(context).size.width * 1,
                    //height: MediaQuery.of(context).size.height * 1,
                  ).blurred(blur: 5, blurColor: Colors.black),
                ),
                Center(
                  child: Image.network(
                    recipe?.foto ?? '',
                    //width: double.infinity,
                    fit: BoxFit.cover,
                    height: 350,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.star, color: Colors.yellow),
                        onPressed: () {
                          // show the dialog
                          showDialog(
                            context: context,
                            barrierDismissible:
                                true, // set to false if you want to force a rating
                            builder: (context) => _dialog,
                          );
                        },
                      ),
                      const Text(
                        'Calificar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              child: Center(
                child: Container(
                  //height: 525,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Información de la receta',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          elevation: 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.attach_money,
                                          color: Colors.orangeAccent),
                                      Text(recipe?.costo ?? ''),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.schedule,
                                          color: Colors.orangeAccent),
                                      Text(recipe?.tiempo ?? ''),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.whatshot,
                                          color: Colors.orangeAccent),
                                      Text(
                                          (recipe?.calorias?.toString() ?? '') +
                                              ' Cal'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Ingredientes',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              recipe?.ingredientes?.join('\n') ?? '',
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Instrucciones',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              recipe?.procedimiento?.join('\n') ?? '',
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 20),
                            _buildAddFavsButton(userCredential),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildLanscapeRecipe(BuildContext context, RatingDialog _dialog,
      UserCredential userCredential) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                child: Image.network(
                  recipe?.foto ?? '',
                  //width: double.infinity,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                ).blurred(blur: 2, blurColor: Colors.black),
              ),
              Center(
                child: Image.network(
                  recipe?.foto ?? '',
                  //width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.star, color: Colors.yellow),
                      onPressed: () {
                        // show the dialog
                        showDialog(
                          context: context,
                          barrierDismissible:
                              true, // set to false if you want to force a rating
                          builder: (context) => _dialog,
                        );
                      },
                    ),
                    const Text(
                      'Calificar',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    child: Container(
                      //height: 525,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Información de la receta',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Card(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.attach_money,
                                            color: Colors.orangeAccent),
                                        Text(recipe?.costo ?? ''),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.schedule,
                                            color: Colors.orangeAccent),
                                        Text(recipe?.tiempo ?? ''),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.whatshot,
                                            color: Colors.orangeAccent),
                                        Text((recipe?.calorias?.toString() ??
                                                '') +
                                            ' Cal'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                'Ingredientes',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                recipe?.ingredientes?.join('\n') ?? '',
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Instrucciones',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                recipe?.procedimiento?.join('\n') ?? '',
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(height: 20),
                              _buildAddFavsButton(userCredential),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildAddFavsButton(UserCredential userCredential) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          StreamBuilder(
            stream: _dbFavs.getFavoriteRecipes(userCredential.user!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingWidget();
              } else if (snapshot.hasError) {
                return LoadingWidget();
              } else if (snapshot.hasData) {
                FavsModel favs =
                    FavsModel.fromQuerySnapshot(snapshot.data!.docs[0]);
                return FutureBuilder(
                  future: _dbReci.getRecipesFromIds(favs.recetas!),
                  builder: (context, snapshot1) {
                    if (snapshot1.connectionState == ConnectionState.waiting) {
                      return LoadingWidget();
                    } 
                    List<String> recipeIds = snapshot1.data
                            ?.map((recipe) => recipe.id ?? '')
                            .toList() ??
                        [];
                    return ElevatedButton.icon(
                      onPressed: () {
                        if (recipeIds.contains(id)) {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.infoReverse,
                              title: 'Confirmar',
                              desc:
                                  '¿Desea eliminar esta receta de sus favoritos?',
                              animType: AnimType.bottomSlide,
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                recipeIds.remove(id);
                                _dbFavs.updateDocument({
                                  'idUsuario': userCredential.user!.uid,
                                  'recetas': recipeIds
                                }, snapshot.data!.docs[0].id);
                              }).show();
                        } else {
                          recipeIds.add(id!);
                          _dbFavs.updateDocument({
                            'idUsuario': userCredential.user!.uid,
                            'recetas': recipeIds
                          }, snapshot.data!.docs[0].id).then(
                            (value) {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      title: 'Agregado con éxito',
                                      desc: 'Se ha agregado correctamente a la lista de favoritos',
                                      animType: AnimType.bottomSlide,
                                      btnOkOnPress: (){}
                                      )
                                  .show();
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orangeAccent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(200, 50)),
                      ),
                      icon: Icon(
                        recipeIds.contains(id)
                            ? Icons.heart_broken
                            : Icons.favorite,
                        color: Colors.white,
                      ),
                      label: Text(
                        recipeIds.contains(id)
                            ? 'Eliminar de favoritos'
                            : 'Agregar a favoritos',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                );
              } else {
                return LoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}
