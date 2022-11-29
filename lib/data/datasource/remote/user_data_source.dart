import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class UserDataSource {
  Future<String?> uploadAvatarToStorage({
    required String name,
    required File file,
  });
  
  Future<List<Reference>> fetchImagesFromStorage();

  Future<List<String>> getImagesUrls(List<Reference> items);
}
