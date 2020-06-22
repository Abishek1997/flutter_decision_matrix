import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class Chart1 extends StatefulWidget {
  final List<Map> result;
  final List finalWinners;
  final List factors;

  Chart1({this.result, this.finalWinners, this.factors}) {}
  @override
  _Chart1State createState() => _Chart1State();
}

class _Chart1State extends State<Chart1> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color middleBarColor = const Color(0xff0E6EB8);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 15;
  int maxScore;
  List<BarChartGroupData> barChartData = [];
  @override
  void initState() {
    // TODO: implement initState
    barChartData = [];
    maxScore = 0;

    widget.finalWinners.forEach((element) {
      var compareObj = [];
      var factorObj = {};
      List<int> tempScore = [];
      for (int i = 0; i < widget.result.length; i++) {
        compareObj = widget.result[i].keys.toList();
        if (compareObj[0] == element) {
          factorObj = widget.result[i][element];
          factorObj.keys.forEach((e) {
            tempScore.add(factorObj[e]);
          });
          maxScore = max(maxScore, tempScore.reduce(max));
          if (tempScore.length == 3) {
            barChartData.add(makeGroupData(i, tempScore[0] * 1.0,
                y2: tempScore[1] * 1.0, y3: tempScore[2] * 1.0));
          } else if (tempScore.length == 2) {
            barChartData.add(
                makeGroupData(i, tempScore[0] * 1.0, y2: tempScore[1] * 1.0));
          } else if (tempScore.length == 1) {
            barChartData.add(makeGroupData(i, tempScore[0] * 1.0));
          }
        }
      }
    });
    super.initState();
  }

  var retval;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
              backgroundColor: Color(0xff985EFF),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 25.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: BarChart(BarChartData(
                  barGroups: barChartData,
                  alignment: BarChartAlignment.center,
                  groupsSpace: 25,
                  backgroundColor: Color(0xff2D4261),
                  barTouchData: BarTouchData(
                      handleBuiltInTouches: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey[900],
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          String factorName;
                          for (int i = 0; i < widget.result.length; i++) {
                            var compare = [];
                            var obj = {};
                            compare = widget.result[i].keys.toList();
                            if (compare[0] == widget.finalWinners[groupIndex]) {
                              obj = widget.result[i]
                                  [widget.finalWinners[groupIndex]];
                              factorName = obj.keys.firstWhere(
                                  (k) => obj[k] == rod.y,
                                  orElse: () => null);
                            }
                          }
                          return BarTooltipItem(
                              '$factorName: ${rod.y}',
                              TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold));
                        },
                      )),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      textStyle: TextStyle(
                          color: const Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      margin: 10,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return widget.finalWinners[0];
                          case 1:
                            return widget.finalWinners[1];
                          case 2:
                            return widget.finalWinners[2];
                        }
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      textStyle: TextStyle(
                          color: const Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      margin: 10,
                      reservedSize: 12,
                      getTitles: (value) {
                        for (int i = 0; i <= maxScore; i += 5) {
                          if (value == i) {
                            return i.toString();
                          }
                        }
                      },
                    ),
                  ),
                )),
              ),
            )));
  }

  BarChartGroupData makeGroupData(int x, double y1,
      {double y2: 0, double y3: 0}) {
    return BarChartGroupData(barsSpace: 20, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: middleBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y3,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }
}
