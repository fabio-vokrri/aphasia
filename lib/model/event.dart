import 'package:uuid/uuid.dart';

class Event {
  final String _id;
  final String _title;
  final DateTime _dateTime;
  bool shouldNotify;

  Event({
    String? id,
    required String title,
    required DateTime dateTime,
    this.shouldNotify = false,
  })  : _id = id ?? const Uuid().v8(),
        _title = title,
        _dateTime = dateTime;

  String get id => _id;
  String get title => _title;
  DateTime get date => _dateTime;

  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "title": _title,
      "date": _dateTime.millisecondsSinceEpoch,
      "shouldNotify": shouldNotify ? 1 : 0,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map["id"],
      title: map["title"],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map["date"]),
      shouldNotify: map["shouldNotify"] == 1,
    );
  }
}
