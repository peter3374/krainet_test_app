import 'dart:io';

abstract class UserDataSource {
  Future<String?> uploadAvatar({
    required String name,
    required File file,
  });
}
