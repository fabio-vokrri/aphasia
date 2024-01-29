import 'package:aphasia/providers/events_provider.dart';
import 'package:aphasia/providers/settings_provider.dart';
import 'package:aphasia/view/components/add_event_bottom_sheet.dart';
import 'package:aphasia/view/components/custom_drawer.dart';
import 'package:aphasia/view/components/events_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Calendario")),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            onDateChanged: (DateTime value) {
              setState(() => _selectedDateTime = value);
            },
          ),
          const Divider(height: 0),
          Expanded(
            child: FutureBuilder(
              future: eventsProvider.isInitCompleted,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Sto caricando gli eventi..."),
                  );
                }

                return EventsList(selectedDateTime: _selectedDateTime);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: SettingsProvider.getIsRightToLeft
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            showDragHandle: true,
            builder: (context) {
              return AddEventBottomSheet(dateTime: _selectedDateTime);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
