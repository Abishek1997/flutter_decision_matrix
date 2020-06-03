import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:math';

class Result extends StatefulWidget {
  final List<Map> factors;
  final List<Map> items;

  @override
  _ResultState createState() => _ResultState();
  Result({this.factors, this.items}) {}
}

class _ResultState extends State<Result> {
  Map<String, int> factorMapping;
  Map<String, int> itemMapping;
  int numFactors;
  int numItems;
  Map<String, int> resultScore;
  List<String> finalWinners;

  @override
  void initState() {
    // TODO: implement initState
    factorMapping = {"High": 10, "Medium": 5, "Low": 2};
    itemMapping = {"Very Poor": 1, "Poor": 2, "Okay": 3, "Good": 4, "Best": 5};
    numFactors = widget.factors.length;
    numItems = widget.items.length;
    resultScore = {};
    finalWinners = [];

    super.initState();
  }

  void resultCalculation() {
    int tempResult;

    print(
        'the factors are ${widget.factors} and the items are ${widget.items}');
    for (int item = 0; item < numItems; item++) {
      tempResult = 0;
      for (int factor = 0; factor < numFactors; factor++) {
        tempResult +=
            itemMapping[widget.items[item]['sliderStringArray'][factor]] *
                factorMapping[widget.factors[factor]['sliderValue']];
      }
      resultScore[widget.items[item]['itemTextFieldValue']] = tempResult;
    }

    var sortedKeys = resultScore.keys.toList(growable: false)
      ..sort((key1, key2) => resultScore[key2].compareTo(resultScore[key1]));
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => resultScore[k]);

    int cutoff = 0;

    for (final iterator in sortedMap.keys) {
      if (cutoff > 2) {
        break;
      }
      finalWinners.add(iterator);
      cutoff += 1;
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    resultCalculation();
    return SafeArea(
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
              child: Text(
                ' Based on the inputted factors\' priorities and the performance of each decision item on each factor, the following are the top 3 decision choices to make',
                style: TextStyle(
                    fontSize: 22.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[100]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 200,
                  child: Card(
                    color: Colors.grey[800],
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.white,
                            ),
                        itemCount: 3,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                finalWinners[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.grey[300]),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
