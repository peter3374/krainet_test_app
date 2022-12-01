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
  Future<void> uploadAvatarToStorage({
    required String fileName,
    required File file,
  }) async {
    final ref = _firebaseStorage.ref('$_imageFolder$fileName');

    await ref.putFile(File(file.path));
  }

  @override
  Future<void> uploadAvatarToStorageWeb({
    required String fileName,
    required Uint8List bytes,
  }) async {
    final ref = _firebaseStorage.ref('$_imageFolder$fileName');
    await ref.putData(bytes);
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

  @override
  Future<void> deleteFile(String url) async {
    await _firebaseStorage.refFromURL(url).delete();
  }
}
