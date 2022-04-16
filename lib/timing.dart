import 'package:flutter/material.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/timetable.dart';
import './models/module.dart';

class TimingFields extends StatefulWidget {
  final int position;
  final List<Module> modules;
  final List<Timetable> timetable;
  final int module_position;
  TimingFields(this.position, this.module_position, this.modules, this.timetable);

  @override
  State<TimingFields> createState() => _TimingFieldWidgetState();
}

class _TimingFieldWidgetState extends State<TimingFields> {
  late TextEditingController _start;
  late TextEditingController _end;

  @override
  void initState() {
    super.initState();
    _start = TextEditingController();
    _end = TextEditingController();
  }

  @override
  void dispose() {
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Timing'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildField(context, 'Start Time:', _start),
              _buildField(context, 'End Time:', _end),
              _submitButton('Submit')
            ],
          ),
        )
      )
    );
  }

  Widget _buildField(BuildContext context, String label, TextEditingController controller){
    return Container(
      child: Column(
        children: [
          _itemTitle(label),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(5),
              border: OutlineInputBorder()
            ),
            controller: controller,
          )
        ]
      ),
    );
  }

  Widget _submitButton(String label) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.blue,
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Colors.blue
        ),
        onPressed: () { 
          _onSubmit(context, _start.text, _end.text);
        },
        child: Text(label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context, String start_time, String end_time) {
    widget.timetable.add(
      Timetable(
        id: widget.timetable.length, 
        day_id: widget.position, 
        module_id: widget.module_position, 
        start_time: start_time, 
        end_time: end_time
      )
    );
    _pushMain(context);
  }

  void _pushMain (BuildContext context) {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute(builder: (context) => TimetableList(widget.timetable, widget.modules)),
      (Route<dynamic>route) => false,
    );
  }

  Widget _itemTitle(String label) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}