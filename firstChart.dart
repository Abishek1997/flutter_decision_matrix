import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart1 extends StatefulWidget {
  @override
  _Chart1State createState() => _Chart1State();
}

class _Chart1State extends State<Chart1> {
  var retval;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Text('View 1')));
  }
}
