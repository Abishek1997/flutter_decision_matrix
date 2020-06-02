import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:hello/showItemDialog.dart';

class ItemList extends StatefulWidget {
  final List<Map> factors;
  ItemList({this.factors}) {}

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Map> items = [];
  bool _isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    items = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.factors.length);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: SafeArea(
            minimum: const EdgeInsets.all(10.0),
            child: new Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.grey[900],
                body: new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text('hello'),
                            );
                          }),
                    )
                  ],
                ),
                floatingActionButton: FabCircularMenu(
                    fabColor: Colors.red[500],
                    ringDiameter: MediaQuery.of(context).size.width * 0.8,
                    ringWidth: MediaQuery.of(context).size.width * 0.6 * 0.3,
                    fabSize: 60.0,
                    fabOpenIcon: Icon(Icons.add),
                    fabCloseColor: Colors.green,
                    fabElevation: 15.0,
                    fabMargin: EdgeInsets.all(15.0),
                    ringColor: Colors.red[500],
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowItemDialog(
                                        factorLength: widget.factors.length),
                                    fullscreenDialog: true));

                            setState(() {});
                          }),
                      IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            setState(() {
                              _isVisible = true;
                            });
                          }),
                      Visibility(
                        visible: _isVisible,
                        child: IconButton(
                            icon: Icon(Icons.send), onPressed: () {}),
                      )
                    ]))));
  }
}