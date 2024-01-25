import 'dart:io';

import 'package:aphasia/constants.dart';
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
        height: kBoxSize,
        width: kBoxSize,
        margin: const EdgeInsets.symmetric(vertical: kSmallSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMediumSize),
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
