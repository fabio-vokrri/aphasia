import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePickerCard extends StatelessWidget {
  const ImagePickerCard({
    super.key,
    this.onTap,
    this.imageBytes,
    this.icon,
    this.content,
  });

  final void Function()? onTap;
  final IconData? icon;
  final String? content;
  final Uint8List? imageBytes;

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
          image: imageBytes != null
              ? DecorationImage(
                  image: MemoryImage(imageBytes!), fit: BoxFit.cover)
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
