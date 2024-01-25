import 'dart:typed_data';

import 'package:aphasia/constants.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.size,
    this.image,
    this.child,
  });

  final double size;
  final Uint8List? image;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(kMediumSize),
        image: image != null
            ? DecorationImage(
                image: MemoryImage(image!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Center(child: child),
    );
  }
}
