import 'package:aphasia/constants.dart';
import 'package:aphasia/extensions/datetime.dart';
import 'package:aphasia/model/event.dart';
import 'package:aphasia/providers/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventBottomSheet extends StatefulWidget {
  const AddEventBottomSheet({super.key, this.dateTime});

  final DateTime? dateTime;

  @override
  State<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends State<AddEventBottomSheet> {
  final _controller = TextEditingController();
  TimeOfDay selectedTimeOfDay = TimeOfDay.now();
  DateTime selectedDateTime = DateTime.now();

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
            "Per il giorno ${DateFormat.yMMMMd("it_IT").format(selectedDateTime)}",
          ),
          const SizedBox(height: kLargeSize),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Nome dell'evento"),
              hintText: "esempio: Logopedista",
            ),
          ),
          const SizedBox(height: kLargeSize),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Seleziona giorno"),
            trailing: IconButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: widget.dateTime ?? selectedDateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                ).then((value) {
                  if (value != null) {
                    setState(() => selectedDateTime = value);
                  }
                });
              },
              icon: const Icon(Icons.calendar_month_outlined),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Seleziona ora"),
            trailing: IconButton(
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
          const SizedBox(height: kLargeSize),
          Align(
            alignment: Alignment.bottomRight,
            child: FilledButton.icon(
              onPressed: () {
                final newEvent = Event(
                  title: _controller.text.isNotEmpty
                      ? _controller.text
                      : "Logopedista",
                  dateTime: selectedDateTime.apply(selectedTimeOfDay),
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
