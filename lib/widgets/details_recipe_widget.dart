import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:recetas/models/recipe_model.dart';
import 'package:recetas/firebase/firebase_db.dart';

class DetailsRecipeScreen extends StatelessWidget {
  RecipeModel? recipe;
  String? id;
  DetailsRecipeScreen({Key? key, this.recipe}) : super(key: key);
  DatabaseFirebase _dbReci = DatabaseFirebase(0);

  @override
  Widget build(BuildContext context) {
    final args =ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    recipe = args['recipe'] as RecipeModel;
    id=args['id'] as String;
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
        recipe!.voteCount = recipe!.voteCount! + 1;
        recipe!.calificacion =
            (recipe!.calificacion! + response.rating) / recipe!.voteCount!;
        await _dbReci.updateDocument(recipe!.toMap(), id!);
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Recipe',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  recipe?.foto ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Información',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.whatshot,
                                    color: Colors.orangeAccent),
                                Text((recipe?.calorias?.toString() ?? '') +
                                    ' Cal'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ingredientes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(recipe?.ingredientes?.join('\n') ?? ''),
                  const SizedBox(height: 10),
                  const Text(
                    'Instrucciones',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(recipe?.procedimiento?.join('\n') ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
