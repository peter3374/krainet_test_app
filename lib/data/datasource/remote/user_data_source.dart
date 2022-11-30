import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class UserDataSource {
  Future<void> uploadAvatarToStorage({
    required String fileName,
    required File file,
  });

  Future<List<Reference>> fetchImagesFromStorage();

  Future<List<String>> getImagesUrls(List<Reference> items);
}
