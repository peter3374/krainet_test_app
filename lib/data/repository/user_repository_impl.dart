import 'package:firebase_storage/firebase_storage.dart';
import 'package:krainet_test_app/data/datasource/remote/user_data_source.dart';
import 'dart:io';
import 'package:krainet_test_app/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;
  UserRepositoryImpl({required UserDataSource userDataSource})
      : _userDataSource = userDataSource;
  @override
  Future<List<Reference>> fetchImagesFromStorage() async =>
      await _userDataSource.fetchImagesFromStorage();

  @override
  Future<List<String>> getImagesUrls(List<Reference> items) async =>
      await _userDataSource.getImagesUrls(items);

  @override
  Future<String?> uploadAvatarToStorage({
    required String name,
    required File file,
  }) async =>
      await _userDataSource.uploadAvatarToStorage(
        file: file,
        name: name,
      );
}
