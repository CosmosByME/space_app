import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImgPickerService {
  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final result = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (result != null) {
      return File(result.path);
    }
    return null;
  }
}
