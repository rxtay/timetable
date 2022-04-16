import 'package:timetable/models/module.dart';

class Timetable {
  final int id;
  final int day_id;
  final int module_id;
  final String start_time;
  final String end_time;

  Timetable({required this.id, required this.day_id, required this.module_id, required this.start_time, required this.end_time});
}