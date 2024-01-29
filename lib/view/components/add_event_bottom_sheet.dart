import 'package:aphasia/constants.dart';
import 'package:aphasia/extensions/datetime.dart';
import 'package:aphasia/model/event.dart';
import 'package:aphasia/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventBottomSheet extends StatefulWidget {
  const AddEventBottomSheet({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  final _controller = TextEditingController();
  TimeOfDay selectedTimeOfDay = TimeOfDay.now();
  bool shouldNotify = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventsProvider = Provider.of<EventsProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kLargeSize) +
          EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + kLargeSize * 2,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Aggiungi un evento",
            style: theme.textTheme.titleLarge!.copyWith(
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: kSmallSize),
          Text(
            "Per il giorno ${DateFormat.yMMMMd("it_IT").format(widget.dateTime)}",
          ),
          const SizedBox(height: kLargeSize),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text("Nome dell'evento"),
              hintText: "esempio: Logopedista",
              suffixIcon: IconButton(
                onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    helpText: "Scegli l'orario della visita",
                  ).then((TimeOfDay? value) {
                    if (value != null) {
                      setState(() => selectedTimeOfDay = value);
                    }
                  });
                },
                icon: const Icon(Icons.schedule),
              ),
            ),
          ),
          const SizedBox(height: kSmallSize),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              colorScheme: ColorScheme.fromSeed(seedColor: kBaseColor),
            ),
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.notification_add),
              title: const Text("Mandami una notifica"),
              value: shouldNotify,
              onChanged: (value) {
                setState(() => shouldNotify = value);
              },
            ),
          ),
          const SizedBox(height: kLargeSize),
          Align(
            alignment: Alignment.bottomRight,
            child: FilledButton.icon(
              onPressed: () {
                final newEvent = Event(
                  title: _controller.text.isNotEmpty
                      ? _controller.text
                      : "Logopedista",
                  dateTime: widget.dateTime.apply(selectedTimeOfDay),
                  shouldNotify: shouldNotify,
                );
                eventsProvider.add(newEvent);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.add),
              label: const Text("Aggiungi visita"),
            ),
          )
        ],
      ),
    );
  }
}
