import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:krainet_test_app/data/datasource/remote/user_data_source.dart';

class UserDataSourceImpl implements UserDataSource {
  final FirebaseStorage _firebaseStorage;

  UserDataSourceImpl({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  @override
  Future<String?> uploadAvatar({
    required String name,
    required File file,
  }) async {
    final ref = _firebaseStorage.ref().child(file.path);
    final responce = kIsWeb
        ? ref.putData(await file.readAsBytes())
        : ref.putFile(File(file.path));
    final url = await responce.snapshot.ref.getDownloadURL();
    return url;
  }
}
