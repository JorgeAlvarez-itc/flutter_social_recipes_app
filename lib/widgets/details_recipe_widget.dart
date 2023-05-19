import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:recetas/models/favs_model.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:recetas/models/recipe_model.dart';
import 'package:recetas/firebase/firebase_db.dart';
import 'package:recetas/responsive/responsive.dart';

class DetailsRecipeScreen extends StatelessWidget {
  RecipeModel? recipe;
  String? id;
  DetailsRecipeScreen({Key? key, this.recipe}) : super(key: key);
  DatabaseFirebase _dbReci = DatabaseFirebase(0);
  FavsModel? favsModel;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    recipe = args['recipe'] as RecipeModel;
    id = args['id'] as String;
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
      body: Stack(
        children: [
          Responsive(
              mobile: _buildMobileRecipe(context, _dialog),
              tablet: _buildLanscapeRecipe(context, _dialog),
              desktop: _buildLanscapeRecipe(context, _dialog),
          )
        ],
      ),
    );
  }

  _buildMobileRecipe(BuildContext context, RatingDialog _dialog) {
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
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ...código anterior...

                                  const SizedBox(height: 20),

                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Lógica para agregar a favoritos
                                    },
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(10),

                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orangeAccent),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(200, 50)),
                                      // Ajusta el tamaño aquí
                                    ),
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'Agregar a favoritos',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  _buildLanscapeRecipe(BuildContext context, RatingDialog _dialog) {
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
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    ElevatedButton.icon(
                                      onPressed: () async {},
                                      style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all(10),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.orangeAccent),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(200, 50)),
                                        // Ajusta el tamaño aquí
                                      ),
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Agregar a favoritos',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
}
