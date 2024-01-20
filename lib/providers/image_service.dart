import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static const double _goldenRatio = 1.61803398875;
  static const double _height = 1000;

  /// picks an image from the given `source`.
  static Future<Uint8List?> pickImageFrom(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: _height,
        maxWidth: _height / (_goldenRatio - 1),
      );

      if (image == null) return null;

      return await image.readAsBytes();
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }
}
