import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'drawerUI.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'firstChart.dart';
import 'secondChart.dart';

class ResultBreakdown extends StatefulWidget {
  @override
  _ResultBreakdownState createState() => _ResultBreakdownState();
}

class _ResultBreakdownState extends State<ResultBreakdown> {
  String imageHolder;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
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
              "Breakdown",
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
          body: Center(
            child: CarouselSlider.builder(
              itemCount: 2,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.4,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.75,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.horizontal),
              itemBuilder: (BuildContext context, int itemIndex) => Container(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GestureDetector(
                    onTap: () {
                      if (itemIndex == 0) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Chart1()));
                      } else if (itemIndex == 1) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Chart2()));
                      }
                    },
                    child: Card(
                      color: Colors.grey[800],
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: new Image.asset(itemIndex == 0
                                ? 'images/bar.png'
                                : 'images/pie.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              'Results Breakdown: ${itemIndex + 1}',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      elevation: 10.0,
                    ),
                  ),
                ),
              ),
            ),
          )),
    ));
  }
}
