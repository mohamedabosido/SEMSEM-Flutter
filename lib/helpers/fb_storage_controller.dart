import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FbStorage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImage({
    required String path,
    required String fileName,
  }) async {
    File file = File(path);
    try {
      await storage.ref('/profile picture/$fileName').putFile(file);
    } catch (e) {
      print(e);
    }
  }
}
