import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCard extends StatelessWidget {
  const ImagePickerCard({
    super.key,
    this.onTap,
    this.image,
    this.icon,
    this.content,
  });

  final void Function()? onTap;
  final IconData? icon;
  final String? content;
  final XFile? image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96,
        width: 96,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: theme.colorScheme.primary,
          image: image != null
              ? DecorationImage(
                  image: FileImage(File(image!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: icon != null
            ? Center(
                child: Icon(
                  icon,
                  color: theme.colorScheme.onPrimary,
                ),
              )
            : null,
      ),
    );
  }
}
