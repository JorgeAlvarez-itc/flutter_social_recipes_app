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

  Stream<QuerySnapshot> getAllDocuments() {
    return _currentCollection.snapshots();
  }

  Stream<QuerySnapshot> getOwnRecipes(String uid) {
    return _currentCollection.where('idUsuario', isEqualTo: uid).snapshots();
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
