import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:recetas/models/recipe_model.dart';

class CardRecipeWidget extends StatelessWidget {
  CardRecipeWidget({Key? key, required this.recipeModel});
  RecipeModel? recipeModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.network(
                    recipeModel!.foto!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.94,
                    height:MediaQuery.of(context).size.height * 0.94,
                  ).blurred(blur: 2,blurColor: Colors.black),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                      bottom: Radius.circular(15)
                    ),
                    child: Image.network(
                      recipeModel!.foto!,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.94,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey),
                    SizedBox(width: 4.0),
                    Text(
                      recipeModel!.tiempo!,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.fireplace, color: Colors.grey),
                    SizedBox(width: 4.0),
                    Text(
                      recipeModel!.calorias!.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.favorite_border, color: Colors.grey),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Text(
              recipeModel!.nombre!,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
