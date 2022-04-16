import 'package:flutter/material.dart';
import 'package:timetable/models/days.dart';
import 'package:timetable/models/module.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/modules.dart';

class DaysList extends StatelessWidget {
  final List<String> days = Days.fetchAll();
  final List<Timetable> timetable;
  final List<Module> modules;
  DaysList(this.timetable, this.modules);

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        appBar: AppBar(
          title: Text('Days'),
        ),
        body: ListView.builder(
          itemCount: days.length,
          itemBuilder: _listViewItemBuilder
        ),
        // floatingActionButton: _floatingButton()
      )
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var day = this.days[index];
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      title: _itemTitle(day),
      onTap: () {
        _pushedModules(context, index, modules);
      },
    );
  }
  
  Widget _itemTitle(String day) {
    return Text(
      day,
    );
  }

  void _pushedModules(BuildContext context, int position, List<Module> modules) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (context) => new Modules(position, modules, timetable)),
    );
  }
}