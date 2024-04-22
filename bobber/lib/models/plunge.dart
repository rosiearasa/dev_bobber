
class Plunge {
  const Plunge({
    required this.id,
    required this.dateTimeStarted,
    required this.dateTimeCompleted,
    required this.duration,
    required this.temperature,
  });
  final String id;
  final DateTime dateTimeStarted;
  final DateTime dateTimeCompleted;
  final int duration;
  final int temperature;
}
