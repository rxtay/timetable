import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetable/models/module.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/timetable.dart';

class ModuleAdd extends StatefulWidget {
  final List<Timetable> timetable;
  final List<Module> modules;

  ModuleAdd(this.timetable, this.modules);
  @override
  State<ModuleAdd> createState() => _ModuleAddWidgetState();
}

class _ModuleAddWidgetState extends State<ModuleAdd> {
  late TextEditingController _name;
  late TextEditingController _url;
  late TextEditingController _credit_units;
  late TextEditingController _info;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _url = TextEditingController();
    _credit_units = TextEditingController();
    _info = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _url.dispose();
    _credit_units.dispose();
    _info.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Module Detail'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildField(context, 'Module Name:', _name, TextInputType.text, 1),
              _buildField(context, 'Image Source:', _url, TextInputType.text, 5),
              _buildField(context, 'Credit Units:', _credit_units, TextInputType.number, 1),
              _buildField(context, 'Info:', _info, TextInputType.text, 5),
              _submitButton('Submit')
            ],
          ),
        )
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
          _onSubmit(context, _name.text, _url.text, int.parse(_credit_units.text), _info.text);
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

  Widget _buildField(BuildContext context, String label, TextEditingController controller, TextInputType type, int maxLines){
    return Container(
      child: Column(
        children: [
          _itemTitle(label),
          TextField(
            maxLines: maxLines,
            keyboardType: type,
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

  void _onSubmit(BuildContext context, String name, String url, int credit_units, String info) {
    widget.modules.add(
      Module(
        id: widget.modules.length, 
        name: name, 
        url: url, 
        credit_units: credit_units, 
        info: info
      )
    );
    _pushMain(context);
  }

  void _pushMain(BuildContext context) {
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