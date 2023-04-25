import 'dart:convert';
import 'package:recetas/models/recipe_model.dart';
import 'package:recetas/models/category_model.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDB {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<List<RecipeModel>> getRecipes() async {
    List<RecipeModel> recipes = [];
    DataSnapshot? snapshot;
    try {
      await _databaseReference.child('recetas').once().then((value) {
        snapshot = value.snapshot;
      });
      if (snapshot != null && snapshot!.value != null) {
        var recipesMap = Map<String, dynamic>.from(snapshot!.value as Map<dynamic, dynamic>);
        var recipesList = recipesMap.entries
            .map((entry) =>
                RecipeModel.fromMap(Map<String, dynamic>.from(entry.value)))
            .toList();
        return recipesList;
      }
    } catch (e) {
      print(e);
    }
    return recipes;
  }

  Future<List<CategoryModel>> getCategory() async {
    List<CategoryModel> categories = [];
    DataSnapshot? snapshot;
    try {
      await _databaseReference.child('categorias').once().then((value) {
        snapshot = value.snapshot;
      });
      if (snapshot != null && snapshot!.value != null) {
        var categoriesMap = Map<String, dynamic>.from(snapshot!.value as Map<dynamic, dynamic>);
        var categoryList = categoriesMap.entries
            .map((entry) =>
                CategoryModel.fromMap(Map<String, dynamic>.from(entry.value)))
            .toList();
        return categoryList;
      }
    } catch (e) {
      print(e);
    }
    return categories;
  }


}
