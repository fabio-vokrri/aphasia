import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static const double _goldenRatio = 1.61803398875;

  /// picks an image from the given `source`.
  static Future<(Uint8List?, String?)?> pickImageFrom(
    ImageSource source, {
    double? height = 1000,
    double? width,
  }) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: height,
        maxWidth: width ?? height! / (_goldenRatio - 1),
      );

      if (image == null) return null;

      return (
        await image.readAsBytes(),
        source == ImageSource.camera ? await _getImageLabel(image) : null,
      );
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

  static Future<String> _getImageLabel(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    ImageLabeler imageLabeler = ImageLabeler(options: ImageLabelerOptions());
    List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    return labels.first.label;
  }
}
