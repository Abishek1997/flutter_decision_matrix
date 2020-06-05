import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

class DrawerUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Color(0xff985EFF), Color(0xff7528FE)])),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: InkWell(
            splashColor: Color(0xffC977FE),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[800]))),
              height: 40,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.home,
                            color: Color(0xffC066FA),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 0, 0),
                          child: Text(
                            'Home',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff985EFF)),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: InkWell(
            splashColor: Color(0xffC977FE),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[800]))),
              height: 40,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.help,
                            color: Color(0xffC066FA),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 0, 0),
                          child: Text(
                            'Help',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff985EFF)),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10),
          child: InkWell(
            splashColor: Color(0xffC977FE),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[800]))),
              height: 40,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.star_border,
                            color: Color(0xffC066FA),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 0, 0),
                          child: Text(
                            'Rate Us',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff985EFF)),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0.0, 10),
          child: InkWell(
            splashColor: Color(0xffC977FE),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[800]))),
              height: 40,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.info,
                            color: Color(0xffC066FA),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 2.0, 0, 0),
                          child: Text(
                            'About Us',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff985EFF)),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}
