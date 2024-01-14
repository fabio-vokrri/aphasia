import 'dart:io';

import 'package:aphasia/extensions/capitalize.dart';
import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/already_added_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final _key = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _focusNode = FocusNode();

  final List<File> _images = [];

  /// picks an image from the given `source`.
  Future<void> pickImageFrom(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      _images.add(File(image.path));
      setState(() {});
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(32.0).add(
        EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aggiungi una nuova parola",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 32.0),
          Form(
            key: _key,
            child: TextFormField(
              controller: _wordController,
              focusNode: _focusNode,
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
                  onPressed: () => pickImageFrom(ImageSource.camera),
                  icon: const Icon(Icons.add_a_photo_rounded),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => pickImageFrom(ImageSource.gallery),
                  child: Container(
                    height: 96,
                    width: 96,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ..._images.map(
                  (File imageFile) {
                    return Container(
                      height: 96,
                      width: 96,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: FileImage(imageFile),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () {
                // if the word has not been yet typed, do nothing
                if (!_key.currentState!.validate()) {
                  _focusNode.unfocus();
                  return;
                }

                // creates a new word with the given content.
                final newWord = Word(_wordController.text.capitalized);
                // adds all the selected images to the new word.
                newWord.addAllImages(_images);
                // otherwise, try to insert it in the words list.
                bool inserted = provider.add(newWord);
                // if the word has been successfully added to the list
                // pop the context and return
                if (inserted) {
                  Navigator.pop(context);
                  return;
                }

                // if the word has not been added, closes the keyboard
                _focusNode.unfocus();
                // and displays a snackbar to warn you so.
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlreadyAddedDialog();
                  },
                );
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
