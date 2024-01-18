import 'dart:typed_data';

import 'package:aphasia/providers/image_service.dart';
import 'package:aphasia/providers/user_provider.dart';
import 'package:aphasia/view/components/image_loader_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChangeProfilePictureDialog extends StatefulWidget {
  const ChangeProfilePictureDialog({super.key});

  @override
  State<ChangeProfilePictureDialog> createState() =>
      _ChangeProfilePictureDialogState();
}

class _ChangeProfilePictureDialogState
    extends State<ChangeProfilePictureDialog> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final theme = Theme.of(context);

    return AlertDialog(
      icon: const Icon(Icons.image),
      title: const Text("Cambia foto profilo"),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _image == null
              ? [
                  ImageLoaderCard(
                    onTap: () async {
                      _image = await ImageService.pickImageFrom(
                        ImageSource.gallery,
                      );

                      setState(() {});
                    },
                    icon: Icons.collections_rounded,
                  ),
                  const SizedBox(width: 16),
                  ImageLoaderCard(
                    onTap: () async {
                      _image = await ImageService.pickImageFrom(
                        ImageSource.camera,
                      );

                      setState(() {});
                    },
                    icon: Icons.add_a_photo_rounded,
                  ),
                ]
              : [
                  ImageLoaderCard(imageBytes: _image),
                  const SizedBox(width: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Non ti piace?"),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () {
                          _image = null;
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text("Riprova"),
                      ),
                    ],
                  )
                ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annulla"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: theme.colorScheme.onPrimary,
          ),
          onPressed: () {
            if (_image != null) {
              userProvider.updateImage(_image);
            }
            Navigator.pop(context);
          },
          child: const Text("Modifica"),
        ),
      ],
    );
  }
}
