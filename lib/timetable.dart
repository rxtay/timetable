import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable/days_list.dart';
import 'package:timetable/info.dart';
import 'package:timetable/module_add.dart';
import '../models/timetable.dart';
import './models/days.dart';
import 'package:grouped_list/grouped_list.dart';
import './models/module.dart';

class TimetableList extends StatelessWidget{
  final List<Timetable> timetable;
  final List<Module> modules;

  TimetableList(this.timetable, this.modules);

  final List<String> days = Days.fetchAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _pushedModule(context);
            }, 
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: GroupedListView<dynamic, String>(
        useStickyGroupSeparators: true,
        itemComparator: (item1, item2) =>
          days[item1.day_id].compareTo(days[item1.day_id]),
        elements: timetable,
        groupBy: (element) => days[element.day_id],
        groupSeparatorBuilder: (value) => Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.black,
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        itemBuilder: (context, element) =>
          Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                _pushedInfo(context, modules[element.module_id]);
              },
              contentPadding: EdgeInsets.all(12),
              title: Text(
                '${element.start_time}-${element.end_time} ${modules[element.module_id].name}'
              )
            )
          )
      ),
      floatingActionButton: _floatingButton(context),
    );
  }

  void _pushedModule(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModuleAdd(timetable, modules),
      )
    );
  }

  void _pushedInfo(BuildContext context, Module module) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Info(module)
    ));
  }

  Widget _floatingButton(context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed:() {
        _pushedAdd(context, Days.fetchAll());
      }
    );
  }

  void _pushedAdd(BuildContext context, List<String> days) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => DaysList(timetable, modules)
    ));
  }
}