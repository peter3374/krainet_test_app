import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:krainet_test_app/core/file_picker_provider.dart';
import 'package:krainet_test_app/domain/repository/user_repository.dart';
import 'package:krainet_test_app/presentation/services/message_service.dart';

class MainScreenController extends ChangeNotifier {
  final UserRepository _userRepository;
  final FilePickerProvider _filePickerProvider;
  bool isAddImageButtonActive = true;

  MainScreenController({
    required UserRepository userRepository,
    required FilePickerProvider filePickerProvider,
  })  : _userRepository = userRepository,
        _filePickerProvider = filePickerProvider;

  Future<void> uploadImage(BuildContext context) async {
    try {
      isAddImageButtonActive = false;
      notifyListeners();
      final pickedImage = await pickImage(context);
      await _userRepository.uploadAvatarToStorage(
          name: pickedImage.name, file: File(pickedImage.path ?? ''));
    } catch (e) {
      MessageService.displaySnackbar(
        context: context,
        message: 'Ошибка загрузки',
      );
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
}
