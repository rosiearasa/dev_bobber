import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Plunge {
  const Plunge({
     this.id,
    required this.dateTimeStarted,
    required this.dateTimeCompleted,
    required this.duration,
    required this.temperature,
  });
  final String? id;
  final DateTime dateTimeStarted;
  final DateTime dateTimeCompleted;
  final int duration;
  final int temperature;

  String get FormattedDate {
    return formatter.format(dateTimeStarted);
  }

  toJson() {
    return {
      "id": id,
         "startDateTime": dateTimeStarted,
            "endDateTime": dateTimeCompleted,
               "duration": duration,
               "temperature":temperature,
    };
  }
}
