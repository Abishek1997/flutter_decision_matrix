import 'package:flutter/material.dart';

class Chart2 extends StatefulWidget {
  @override
  _Chart2State createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
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
            body: Text('Chart2')));
  }
}
