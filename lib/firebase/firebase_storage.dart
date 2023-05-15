import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadFile(File file, String id) async {
    try {
      final ref = _storage.ref().child(id+'.jpg');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
