import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:nice_button/nice_button.dart';
import 'drawerUI.dart';
import 'package:getflutter/getflutter.dart';
import 'resultsBreakdown.dart';

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
  TextEditingController searchTextController = new TextEditingController();
  Map<String, int> resultScore;
  List<String> finalWinners;
  List<double> finalWinnersScoreNormalized;
  int cutoff;
  List<Map> resultBreakDown;
  List<String> finalWinnersAll;
  List<double> finalWinnersScoreNormalizedAll;
  var sortedFactors;
  @override
  void initState() {
    // TODO: implement initState
    factorMapping = {"High": 10, "Medium": 5, "Low": 2};
    itemMapping = {"Very Poor": 1, "Poor": 2, "Okay": 3, "Good": 4, "Best": 5};
    numFactors = widget.factors.length;
    numItems = widget.items.length;
    resultScore = {};
    finalWinners = [];
    cutoff = 0;
    finalWinnersScoreNormalized = [];
    resultBreakDown = [];
    sortedFactors = [];
    finalWinnersAll = [];
    finalWinnersScoreNormalizedAll = [];
    super.initState();
  }

  void resultCalculation() {
    int tempResult;
    int tempObjResult;
    int tempCount;

    for (int item = 0; item < numItems; item++) {
      tempResult = 0;
      tempCount = 1;
      Map<String, Map> tempObj = {};
      tempObj[widget.items[item]['textFieldValue']] = Map<String, int>();
      tempObjResult = 0;
      for (int factor = 0; factor < numFactors; factor++) {
        tempResult +=
            itemMapping[widget.items[item]['sliderStringArray'][factor]] *
                factorMapping[widget.factors[factor]['sliderValue']];

        tempObjResult =
            itemMapping[widget.items[item]['sliderStringArray'][factor]] *
                factorMapping[widget.factors[factor]['sliderValue']];

        tempObj[widget.items[item]['textFieldValue']].keys.forEach((element) {
          if (tempObj[widget.items[item]['textFieldValue']][element] ==
              tempObjResult) {
            tempObj[widget.items[item]['textFieldValue']][element] += tempCount;
            tempCount += 1;
          }
        });

        tempObj[widget.items[item]['textFieldValue']]
            [widget.factors[factor]['textFieldValue']] = tempObjResult;
      }

      resultScore[widget.items[item]['textFieldValue']] = tempResult;

      sortedFactors = tempObj[widget.items[item]['textFieldValue']].keys.toList(
          growable: false)
        ..sort((key1, key2) => tempObj[widget.items[item]['textFieldValue']]
                [key2]
            .compareTo(tempObj[widget.items[item]['textFieldValue']][key1]));
      LinkedHashMap sortedFactorsMap = new LinkedHashMap.fromIterable(
          sortedFactors,
          key: (k) => k,
          value: (k) => tempObj[widget.items[item]['textFieldValue']][k]);
      tempObj[widget.items[item]['textFieldValue']] = sortedFactorsMap;
      resultBreakDown.add(tempObj);
    }

    var sortedKeys = resultScore.keys.toList(growable: false)
      ..sort((key1, key2) => resultScore[key2].compareTo(resultScore[key1]));
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => resultScore[k]);

    int factorCutoff = 0;

    for (int i = 0; i < resultBreakDown.length; i++) {
      factorCutoff = 0;

      for (final key in resultBreakDown[i].keys) {
        var tempObj = {};
        for (final factor in resultBreakDown[i][key].keys) {
          if (factorCutoff > 2) break;
          tempObj[factor] = resultBreakDown[i][key][factor];
          factorCutoff += 1;
        }
        resultBreakDown[i][key] = tempObj;
      }
    }

    if (sortedMap.length < 3) {
      sortedMap.keys.forEach((element) {
        finalWinners.add(element);
        finalWinnersScoreNormalized.add(sortedMap[element] * 1.0);
      });
    } else {
      for (final iterator in sortedMap.keys) {
        if (cutoff > 2) {
          break;
        }
        finalWinners.add(iterator);
        finalWinnersScoreNormalized.add(sortedMap[iterator] * 1.0);
        cutoff += 1;
      }
    }

    for (final iterator in sortedMap.keys) {
      finalWinnersAll.add(iterator);
      finalWinnersScoreNormalizedAll.add(sortedMap[iterator] * 1.0);
      cutoff += 1;
    }

    double tempVal = finalWinnersScoreNormalized[0];

    for (int iter = 0; iter < finalWinnersScoreNormalized.length; iter++) {
      finalWinnersScoreNormalized[iter] =
          (finalWinnersScoreNormalized[iter] / tempVal) * 100;
    }

    double tempValAll = finalWinnersScoreNormalizedAll.reduce((a, b) => a + b);
    for (int iter = 0; iter < finalWinnersScoreNormalizedAll.length; iter++) {
      finalWinnersScoreNormalizedAll[iter] = double.parse(
          ((finalWinnersScoreNormalizedAll[iter] / tempValAll) * 100)
              .toStringAsFixed(2));
    }
  }

  @override
  Widget build(BuildContext context) {
    resultCalculation();
    return Material(
      color: Colors.grey[900],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: GFAppBar(
            iconTheme: new IconThemeData(color: Color(0xff985EFF)),
            elevation: 3.0,
            searchBarColorTheme: Color(0xff985EFF),
            backgroundColor: Colors.grey[900],
            searchBar: false,
            searchHintStyle: TextStyle(color: Colors.white),
            title: Text(
              "Results",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Color(0xff985EFF),
                  letterSpacing: 1.0),
            ),
            actions: <Widget>[
              GFIconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Color(0xff985EFF),
                ),
                iconSize: 25.0,
                onPressed: () {},
                type: GFButtonType.transparent,
              ),
            ],
          ),
          drawer: DrawerUI(),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.grey[800], Colors.grey[900]],
                    tileMode: TileMode.mirror)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[800]),
                            top: BorderSide(color: Colors.grey[800]),
                            left: BorderSide(color: Colors.grey[800]),
                            right: BorderSide(color: Colors.grey[800])),
                        gradient: LinearGradient(
                            colors: [Color(0xff22BFFF), Color(0xff0068FF)])),
                    child: Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 5.0),
                        child: Text(
                          ' The top ${finalWinners.length > 3 ? 3 : finalWinners.length} decision choices to choose based on your input are:',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[300]),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          itemCount: finalWinners.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    '${finalWinners[index].toString().toUpperCase()}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xff985EFF),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: new LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    animation: true,
                                    lineHeight: 25.0,
                                    animationDuration: 2000,
                                    percent:
                                        finalWinnersScoreNormalized[index] /
                                            100,
                                    center: Text(
                                      '${finalWinnersScoreNormalized[index].toStringAsFixed(0)}%',
                                      style: TextStyle(
                                          color: Color(0xff7700e6),
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Color(0xff02bfa3),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20, 0, 20),
                  child: NiceButton(
                    elevation: 5,
                    background: null,
                    radius: 20,
                    fontSize: 25,
                    gradientColors: [Color(0xffc180ff), Color(0xff420080)],
                    padding: EdgeInsets.all(5.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultBreakdown(
                                  result: resultBreakDown,
                                  finalWinners: finalWinners,
                                  factors: sortedFactors,
                                  finalWinnersAll: finalWinnersAll,
                                  finalWinnersScoreNormalized:
                                      finalWinnersScoreNormalizedAll)));
                    },
                    text: 'Results breakdown',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
