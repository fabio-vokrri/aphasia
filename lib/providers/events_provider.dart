import 'package:aphasia/db/events_db.dart';
import 'package:aphasia/model/event.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  Future? isInitCompleted;
  final EventsDatabaseService _databaseService;

  List<Event> _events = [];

  EventsProvider() : _databaseService = EventsDatabaseService() {
    isInitCompleted = init();
  }

  Future<void> init() async {
    _events = await _databaseService.getEvents;
  }

  void add(Event event) async {
    _events.add(event);
    _databaseService.add(event);
    notifyListeners();
  }

  void remove(Event event) async {
    _events.remove(event);
    _databaseService.remove(event);
    notifyListeners();
  }

  List<Event> filterBy(DateTime dateTime) {
    return _events.where((Event element) {
      return element.date.year == dateTime.year &&
          element.date.month == dateTime.month &&
          element.date.day == dateTime.day;
    }).toList()
      ..sort((a, b) {
        return a.date.compareTo(b.date);
      });
  }
}
