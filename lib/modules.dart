import 'package:flutter/material.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/timing.dart';
import './models/module.dart';

class Modules extends StatelessWidget {
  final int position;
  final List<Module> modules;
  List<Timetable> timetable;
  Modules(this.position, this.modules, this.timetable);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Modules'),
        ),
        body: ListView.builder(
          itemCount: modules.length,
          itemBuilder: _listViewItemBuilder,
        ),
      );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var module = modules[index];
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      title: _itemTitle(module),
      onTap: () {
        _pushedTiming(context, timetable, modules, position, index);
      },
    );
  }

  void _pushedTiming (BuildContext context, List<Timetable> timetable, List<Module> modules, int timetable_position, int module_position) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => TimingFields(timetable_position, module_position, modules, timetable)
    ));
  }

  Widget _itemTitle(Module module) {
    return Text(
      module.name
    );
  }
}