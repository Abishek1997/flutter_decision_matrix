import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'indicator.dart';
import 'dart:math';

class Chart2 extends StatefulWidget {
  final List winners;
  final List winnersScore;

  Chart2({this.winners, this.winnersScore}) {}
  @override
  _Chart2State createState() => _Chart2State();
}

class _Chart2State extends State<Chart2> {
  int touchedIndex;
  List<Color> colorArray;
  List<int> rgb;
  Random random = new Random();

  @override
  void initState() {
    // TODO: implement initState
    colorArray = [];
    for (int iter = 0; iter < widget.winners.length; iter++) {
      rgb = [];
      for (int iterator = 0; iterator < 3; iterator++) {
        rgb.add(random.nextInt(256) + 50);
      }
      colorArray.add(Color.fromRGBO(rgb[0], rgb[1], rgb[2], 0.7));
    }
    super.initState();
  }

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
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Card(
              elevation: 5.0,
              color: Colors.grey[900],
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.1,
                            0,
                            25.0,
                            0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(
                                    touchCallback: (pieTouchResponse) {
                                  setState(() {
                                    if (pieTouchResponse.touchInput
                                            is FlLongPressEnd ||
                                        pieTouchResponse.touchInput
                                            is FlPanEnd) {
                                      touchedIndex = -1;
                                    } else {
                                      touchedIndex =
                                          pieTouchResponse.touchedSectionIndex;
                                    }
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 15,
                                centerSpaceRadius: 40,
                                sections: showingSections()),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      widget.winners.length,
      (i) {
        final isTouched = i == touchedIndex;
        final double opacity = isTouched ? 1 : 0.6;
        return PieChartSectionData(
          color: colorArray[i],
          value: widget.winnersScore[i],
          title: '${widget.winners[i]}:\n${widget.winnersScore[i]}%',
          radius: MediaQuery.of(context).size.height * 0.12,
          titleStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color(0xff4c3788)),
          titlePositionPercentageOffset: 0.6,
        );
      },
    );
  }
}
