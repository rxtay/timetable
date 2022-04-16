import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable/models/module.dart';

class Info extends StatelessWidget {
  final Module module;
  Info(this.module);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _renderBody(context, module),
      )
    );
  }

  List<Widget> _renderBody(BuildContext context, Module module) {
    var result = <Widget>[];
    result.add(_bannerImage(module.url, 200.0));
    result.add(_sectionTitle(module.name));
    result.add(_sectionText('Credit Units: ${module.credit_units}'));
    result.add(_sectionText(module.info));
    // To be filled
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Text(text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black
      )
      )
    );
  }

  Widget _sectionText(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17.0,
          color: Color(int.parse('666666'.substring(0, 6), radix: 16) + 
            0xFF000000)
        )
      ) 
      );
  }



  Widget _bannerImage(String url, double height) {
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      // fit determines how the image is placed in the container
      child: Image.network(url, fit:BoxFit.fitWidth)
    );
  }
}