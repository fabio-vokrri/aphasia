import 'package:aphasia/extensions/capitalize.dart';
import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/image_service.dart';
import 'package:aphasia/providers/tts_provider.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:aphasia/view/components/image_loader_card.dart';
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
  double goldenRatio = 1.61803398875;
  final _key = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _focusNode = FocusNode();

  Uint8List? _image;

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordProvider>(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0) +
          EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
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
          const SizedBox(height: 32.0),
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
          const SizedBox(height: 32.0),
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
                  image: _image,
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
