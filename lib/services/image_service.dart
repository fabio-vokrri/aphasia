import 'package:aphasia/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
// import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';

/// Wrapper class for ImageProvider and MLKit
class ImageService {
  /// Picks an image from the given `source`.
  ///
  /// If the `source` is set to `ImageSource.gallery`, it lets you select an image from the device's gallery,
  /// else (`source` set to `ImageSource.camera`) it lets you take a picture.
  static Future<XFile?> pickImageFrom(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: imageHeight,
        maxWidth: imageHeight / (goldenRatio - 1),
      );
      if (image != null) return image;
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }

    return null;
  }

  /// Analyzes the given `image` and gets the labels describing it in the given `language`.
  ///
  /// If `language` is null the label language will be be set to english.
  // static Future<String> getLabel(
  //   XFile image, {
  //   TranslateLanguage? language,
  // }) async {
  //   final inputImage = InputImage.fromFilePath(image.path);
  //   final imageLabeler = ImageLabeler(
  //     options: ImageLabelerOptions(confidenceThreshold: 0.5),
  //   );

  //   final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

  //   if (language == null) return labels.first.label;

  //   final translator = OnDeviceTranslator(
  //     sourceLanguage: TranslateLanguage.english,
  //     targetLanguage: language,
  //   );

  //   final result = await translator.translateText(labels.first.label);
  //   translator.close();
  //   return result;
  // }
}
