import 'package:flutter/material.dart';
import 'package:recetas/models/recipe_model.dart';

class RecipeWidget extends StatelessWidget {
  RecipeWidget({Key? key, required this.recipeModel});
  RecipeModel? recipeModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primera columna con la imagen de la receta
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    recipeModel!.foto!,
                    fit: BoxFit.cover,
                    height: 150,
                  ),
                ),
              ),
            ),
            // Segunda columna con la información de la receta
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titulo en negritas con el nombre de la receta
                    Text(
                      recipeModel!.nombre.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    // Lista vertical con la información de la receta
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time),
                            SizedBox(width: 8.0),
                            Text(recipeModel!.tiempo.toString()),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(Icons.local_fire_department),
                            SizedBox(width: 8.0),
                            Text(recipeModel!.calorias.toString()),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 8.0),
                            Text(recipeModel!.calificacion.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
