import 'dart:io';

import 'package:aphasia/constants.dart';
import 'package:aphasia/extensions/capitalize.dart';
import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/image_service.dart';
import 'package:aphasia/providers/tts_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/image_picker_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddWordBottomSheet extends StatefulWidget {
  const AddWordBottomSheet({super.key});

  @override
  State<AddWordBottomSheet> createState() => _AddWordBottomSheetState();
}

class _AddWordBottomSheetState extends State<AddWordBottomSheet> {
  double goldenRatio = 1.61803398875;

  final _key = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _focusNode = FocusNode();

  XFile? _imageData;
  bool isAnalysingImage = false;

  @override
  void dispose() {
    _wordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordProvider>(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kLargeSize) +
          EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + kLargeSize * 2,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aggiungi una nuova parola",
            style: theme.textTheme.titleLarge!
                .copyWith(overflow: TextOverflow.fade),
          ),
          const SizedBox(height: kLargeSize),
          Form(
            key: _key,
            child: TextFormField(
              controller: _wordController,
              focusNode: _focusNode,
              maxLength: 50,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Inserisci una parola";
                }
                return null;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: const Text("Parola"),
                suffixIcon: IconButton(
                  onPressed: () => TTSProvider.speak(_wordController.text),
                  icon: const Icon(Icons.volume_up_rounded),
                  tooltip: "Riproduci parola",
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImagePickerCard(
                onTap: () async {
                  if (_imageData == null) {
                    _imageData = await ImageService.pickImageFrom(
                      ImageSource.gallery,
                    );

                    setState(() {});
                  }
                },
                icon: _imageData == null ? Icons.collections_rounded : null,
                image: _imageData,
              ),
              const SizedBox(width: kMediumSize),
              ImagePickerCard(
                onTap: () async {
                  // if the image has not been selected yet open the image picker,
                  // else discard the choice.
                  if (_imageData == null) {
                    _imageData = await ImageService.pickImageFrom(
                      ImageSource.camera,
                    );
                  } else {
                    _imageData = null;
                  }
                  setState(() {});
                },
                icon: _imageData == null
                    ? Icons.add_a_photo_rounded
                    : Icons.refresh,
              ),
            ],
          ),
          const SizedBox(height: kLargeSize),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () {
                // if the word has not been typed yet, do nothing
                if (!_key.currentState!.validate()) {
                  _focusNode.unfocus();
                  return;
                }

                // creates a new word with the given content and adds all the corresponding images
                final newWord = Word(
                  _wordController.text.capitalized,
                  image: _imageData != null
                      ? File(_imageData!.path).readAsBytesSync()
                      : null,
                );

                provider.add(newWord);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.add),
              label: const Text("Aggiungi alle parole"),
            ),
          )
        ],
      ),
    );
  }
}
