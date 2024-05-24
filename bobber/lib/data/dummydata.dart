//create a list of connected devices

//create user data sample for the widgets

import 'package:bobber/models/plunge.dart';

final items = List<DateTime>.generate(
    10,
    (i) => DateTime.utc(
          DateTime.now().year,
          DateTime.now().month - 10,
          DateTime.now().day,
        ).add(Duration(days: i)));

var plungeItems = [
  Plunge(
    
      id: "p1",
      dateTimeStarted: items[0],
      dateTimeCompleted: items[0].add(const Duration(minutes: 10)),
      duration: 10,
      temperature: -2),
  Plunge(
      id: "p2",
      dateTimeStarted: items[1],
      dateTimeCompleted: items[1].add(const Duration(minutes: 10)),
      duration: 10,
      temperature: -2),
  Plunge(
      id: "p3",
      dateTimeStarted: items[2],
      dateTimeCompleted: items[2].add(const Duration(minutes: 11)),
      duration: 11,
      temperature: -2),
  Plunge(
      id: "p4",
      dateTimeStarted: items[3],
      dateTimeCompleted: items[3].add(const Duration(minutes: 5)),
      duration: 5,
      temperature: -2),
  Plunge(
      id: "p5",
      dateTimeStarted: items[4],
      dateTimeCompleted: items[4].add(const Duration(minutes: 16)),
      duration: 16,
      temperature: -2),
  Plunge(
      id: "p6",
      dateTimeStarted: items[5],
      dateTimeCompleted: items[5].add(const Duration(minutes: 10)),
      duration: 10,
      temperature: -2),
  Plunge(
      id: "p7",
      dateTimeStarted: items[6],
      dateTimeCompleted: items[6].add(const Duration(minutes: 6)),
      duration: 6,
      temperature: -2),
];
