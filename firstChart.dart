import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart1 extends StatefulWidget {
  @override
  _Chart1State createState() => _Chart1State();
}

class _Chart1State extends State<Chart1> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 15;
  List<BarChartGroupData> barChartData = [];
  @override
  void initState() {
    // TODO: implement initState
    barChartData = [
      makeGroupData(0, 5, 12),
      makeGroupData(1, 3, 11),
      makeGroupData(2, 9, 15),
      makeGroupData(3, 1, 2),
      makeGroupData(4, 5, 8)
    ];
    super.initState();
  }

  var retval;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.grey[900],
            appBar: AppBar(
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
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: BarChart(BarChartData(
                  barGroups: barChartData,
                  alignment: BarChartAlignment.center,
                  groupsSpace: 20,
                  maxY: 20,
                  backgroundColor: Color(0xff2D4261),
                  barTouchData: BarTouchData(handleBuiltInTouches: true),
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
                        return value.toInt().toString();
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
                        if (value == 0) {
                          return '0';
                        } else if (value == 5) {
                          return '5';
                        } else if (value == 10) {
                          return '10';
                        } else if (value == 15) {
                          return '15';
                        } else if (value == 20) {
                          return '20';
                        } else {
                          return '';
                        }
                      },
                    ),
                  ),
                )),
              ),
            )));
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 15, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }
}
