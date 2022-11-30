import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:krainet_test_app/core/file_picker_provider.dart';
import 'package:krainet_test_app/domain/repository/user_repository.dart';

class MainScreenController extends ChangeNotifier {
  final UserRepository _userRepository;
  final FilePickerProvider _filePickerProvider;
  bool isAddImageButtonActive = true;

  MainScreenController({
    required UserRepository userRepository,
    required FilePickerProvider filePickerProvider,
  })  : _userRepository = userRepository,
        _filePickerProvider = filePickerProvider;

  Future<void> uploadImage(
    BuildContext context,
    VoidCallback updateState,
  ) async {
    try {
      isAddImageButtonActive = false;
      notifyListeners();
      final pickedImage = await pickImage(context);
      await _userRepository
          .uploadAvatarToStorage(
              name: pickedImage.name, file: File(pickedImage.path ?? ''))
          .then((_) => updateState());
    } finally {
      isAddImageButtonActive = true;
      notifyListeners();
    }
  }

  Future<PlatformFile> pickImage(BuildContext context) async =>
      await _filePickerProvider.pickFile(context: context);

  Future<List<String>> getImagesUrls() async {
    final referenceLen = await _userRepository.fetchImagesFromStorage();
    return await _userRepository.getImagesUrls(referenceLen);
  }

  Future<void> _deleteFile(String url, VoidCallback updateCallback) async =>
      await _userRepository.deleteFile(url).then((_) => updateCallback());

  Future<void> confirmDeleteFile(
    String url,
    BuildContext context,
    VoidCallback updateCallback,
  ) async =>
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Удалить?"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async => _deleteFile(url, () {
                      Navigator.pop(context);
                      updateCallback();
                    }),
                    child: const Text("Да"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Нет"),
                  ),
                ],
              ),
            );
          });
}
