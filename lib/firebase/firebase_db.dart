import 'package:recetas/models/recipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseFirebase {
  FirebaseFirestore? _fire;
  late List<String> _collections;
  late CollectionReference _currentCollection;

  DatabaseFirebase(int index) {
    _fire = FirebaseFirestore.instance;
    _collections = ['recetas', 'categorias', 'favoritos'];
    _currentCollection = _fire!.collection(_collections[index]);
  }

  Future<RecipeModel?> getRecipeWithHighestRating() async {
    QuerySnapshot snapshot = await _currentCollection
        .orderBy('calificacion', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      QueryDocumentSnapshot document = snapshot.docs.first;
      return RecipeModel.fromQuerySnapshot(document);
    }

    return null;
  }

  Stream<QuerySnapshot> getOwnRecipes(String uid) {
    return _currentCollection.where('idUsuario', isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot> getFavoriteRecipes(String userId) {
    return _currentCollection.where('idUsuario', isEqualTo: userId).snapshots();
  }

  Future<List<RecipeModel>> getRecipesFromIds(List<String> recipeIds) async {
    QuerySnapshot snapshot = await _fire!
        .collection('recetas')
        .where(FieldPath.documentId, whereIn: recipeIds)
        .get();

    List<RecipeModel> recipes = [];
    for (QueryDocumentSnapshot document in snapshot.docs) {
      RecipeModel recipe = RecipeModel.fromQuerySnapshot(document);
      recipes.add(recipe);
    }
    return recipes;
  }

  Stream<QuerySnapshot> getAllRecipesByCat(String idCat) {
    return _currentCollection
        .where('idCategoria', isEqualTo: idCat)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllDocuments() {
    return _currentCollection.snapshots();
  }

  Future<void> insertDocument(Map<String, dynamic> map) async {
    return _currentCollection.doc().set(map);
  }

  Future<void> updateDocument(Map<String, dynamic> map, String id) async {
    return _currentCollection.doc(id).update(map);
  }

  Future<void> deleteDocument(String id) async {
    return _currentCollection.doc(id).delete();
  }
}
