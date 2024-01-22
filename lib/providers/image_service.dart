import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static const double _goldenRatio = 1.61803398875;
  static const double _height = 1000;

  /// picks an image from the given `source`.
  static Future<XFile?> pickImageFrom(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: _height,
        maxWidth: _height / (_goldenRatio - 1),
      );
      if (image != null) return image;
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }

    return null;
  }

  static Future<String> getLabel(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final imageLabeler = ImageLabeler(
      options: ImageLabelerOptions(confidenceThreshold: 0.5),
    );

    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    final translator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.italian,
    );

    final result = await translator.translateText(labels.first.label);
    translator.close();
    return result;
  }
}
