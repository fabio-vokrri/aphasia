import 'package:aphasia/model/word.dart';
import 'package:aphasia/providers/word_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final _wordController = TextEditingController();
  final _focusNode = FocusNode();
  final List<Image> _imageList = [];

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
          TextFormField(
            controller: _wordController,
            focusNode: _focusNode,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Parola"),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // "add new image" logic
                },
                child: Container(
                  height: 96,
                  width: 96,
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
              ..._imageList,
            ],
          ),
          const SizedBox(height: 32.0),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: () {
                // if the word has not been yet typed, do nothing
                if (_wordController.text.isEmpty) {
                  _focusNode.unfocus();
                  return;
                }

                // otherwise, try to insert it in the words list.
                bool inserted = provider.add(Word(_wordController.text));
                // if the word has been successfully added to the list
                // pop the context and return
                if (inserted) {
                  Navigator.pop(context);
                  return;
                }

                // if the word has not been added, closes the keyboard
                _focusNode.unfocus();
                // and displays a snackbar to warn you so.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      "Questa parola è già stata agginuta alla tua lista!",
                    ),
                  ),
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
