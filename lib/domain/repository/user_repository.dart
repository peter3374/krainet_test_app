import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

abstract class UserRepository {
  Future<void> uploadAvatarToStorage({
    required String name,
    required File file,
  });
  
  Future<void> uploadAvatarToStorageWeb({
    required String fileName,
    required Uint8List bytes,
  });

  Future<List<Reference>> fetchImagesFromStorage();

  Future<List<String>> getImagesUrls(List<Reference> items);

  Future<void> deleteFile(String url);
}
