import 'package:animations/animations.dart';
import 'package:aphasia/constants.dart';
import 'package:aphasia/providers/events_provider.dart';
import 'package:aphasia/view/components/delete_event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    super.key,
    required this.selectedDateTime,
  });

  final DateTime selectedDateTime;

  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventsProvider>(context);
    final theme = Theme.of(context);

    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: kDuration),
      reverse: true,
      transitionBuilder: (
        Widget child,
        Animation<double> primaryAnimation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
      child: eventsProvider.filterBy(selectedDateTime).isEmpty
          ? Center(
              key: ValueKey(selectedDateTime),
              child: const Text(
                "Nessun evento programmato per questo giorno",
              ),
            )
          : ListView.builder(
              key: ValueKey(selectedDateTime),
              itemCount: eventsProvider.filterBy(selectedDateTime).length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kMediumSize,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kMediumSize,
                      ),
                      child: Text(
                        "Eventi del ${DateFormat.yMMMMd("it_IT").format(selectedDateTime)}",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  );
                }

                final event = eventsProvider.filterBy(
                  selectedDateTime,
                )[index - 1];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(
                    "Fissato alle ore ${DateFormat.Hm().format(event.date)}",
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteEventDialog(event: event);
                        },
                      ).then((value) {
                        if (value is bool && value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Evento ${event.title} eliminato",
                              ),
                              action: SnackBarAction(
                                label: "Annulla",
                                onPressed: () => eventsProvider.add(event),
                              ),
                            ),
                          );
                        }
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
