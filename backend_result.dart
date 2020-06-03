import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final List<Map> factors;
  final List<Map> items;

  @override
  _ResultState createState() => _ResultState();
  Result({this.factors, this.items}) {}
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    // TODO: implement initState

    print(
        'the factors are ${widget.factors} and the items are ${widget.items}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
