import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:krainet_test_app/data/datasource/remote/user_data_source.dart';

class UserDataSourceImpl implements UserDataSource {
  final FirebaseStorage _firebaseStorage;

  UserDataSourceImpl({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  final _imageFolder = 'images/';

  @override
  Future<String?> uploadAvatarToStorage({
    required String name,
    required File file,
  }) async {
    try {
      final ref = _firebaseStorage.ref('$_imageFolder$name');
      final responce = kIsWeb
          ? ref.putData(await file.readAsBytes())
          : ref.putFile(File(file.path));
      final url = await responce.snapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      log('e $e');
      throw '';
    }
  }

  @override
  Future<List<Reference>> fetchImagesFromStorage() async {
    final results = await _firebaseStorage.ref(_imageFolder).listAll();
    return results.items;
  }

  @override
  Future<List<String>> getImagesUrls(List<Reference> items) async {
    final urlList = <String>[];
    if (items.isNotEmpty) {
      for (var i = 0; i < items.length; i++) {
        urlList.add(await items[i].getDownloadURL());
      }
      return urlList;
    }
    return [];
  }
}
