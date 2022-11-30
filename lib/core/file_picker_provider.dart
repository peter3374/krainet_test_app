import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:krainet_test_app/presentation/services/message_service.dart';

const _jpeg = 'jpeg';
const _png = 'png';
const _jpg = 'jpg';

class FilePickerProvider {
  // TODO add web picker!
  // Uint8List uploadfile = result.files.single.bytes;
  Future<PlatformFile> pickFile({required BuildContext context}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: [
        _jpeg,
        _png,
        _jpg,
      ],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      // TODO add for web 
  //     Uint8List fileBytes = result.files.first.bytes;
  // String fileName = result.files.first.name;
  
  // // Upload file
  // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);

      return file;
    } else {
      throw MessageService.displaySnackbar(
        context: context,
        message: 'Изображение не выбрано',
      );
    }
  }
}
