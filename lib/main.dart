import 'package:flutter/material.dart';
import 'package:timetable/models/days.dart';
import 'package:timetable/models/module.dart';
import 'package:timetable/models/timetable.dart';
import './days_list.dart';
import './timetable.dart';

void main() {
  final List<Timetable> timetable = [];

  final List<Module> modules = [];

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => TimetableList(timetable, modules),
    },
  ));
}


