import 'package:aphasia/model/event.dart';
import 'package:aphasia/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteEventDialog extends StatelessWidget {
  const DeleteEventDialog({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventsProvider>(context);
    return AlertDialog(
      icon: const Icon(Icons.delete),
      title: const Text("Eliminare evento?"),
      content: const Text(
        "Una volta eliminato, l'evento non potrà più essere recuperato.\n\n"
        "Sicuro di voler procedere?",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Annulla"),
        ),
        TextButton(
          onPressed: () {
            eventsProvider.remove(event);
            Navigator.pop(context, true);
          },
          child: const Text("Elimina"),
        )
      ],
    );
  }
}
