import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:hello/showItemDialog.dart';
import 'itemListElement.dart';
import 'backend_result.dart';
import 'package:getflutter/getflutter.dart';
import 'searchFunction.dart';
import 'drawerUI.dart';

class ItemList extends StatefulWidget {
  final List<Map> factors;
  ItemList({this.factors}) {}

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Map> items = [];
  bool _isVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchTextController =
      new TextEditingController();
  List<Map> itemsDuplicate = [];

  @override
  void initState() {
    // TODO: implement initState
    items = [];
    itemsDuplicate = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: SafeArea(
            minimum: const EdgeInsets.only(top: 20.0),
            child: new Scaffold(
                key: _scaffoldKey,
                drawer: DrawerUI(),
                appBar: GFAppBar(
                  elevation: 3.0,
                  leading: GFIconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Color(0xff985EFF),
                    ),
                    onPressed: () {},
                    type: GFButtonType.transparent,
                  ),
                  backgroundColor: Colors.grey[900],
                  searchBar: true,
                  searchHintText: 'Search items..',
                  searchBarColorTheme: Color(0xff985EFF),
                  searchController: searchTextController,
                  onChanged: (text) {
                    List<Map> returnData = SearchFunction()
                        .filterSearchResults(text, items, itemsDuplicate);
                    setState(() {
                      items = returnData;
                    });
                  },
                  searchHintStyle: TextStyle(color: Colors.white),
                  title: Text(
                    "Decision Choices",
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
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.grey[900],
                body: new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    1.0, 2.0, 1.0, 0.0),
                                child: ItemListElement(
                                    listObject: items[index],
                                    index: index,
                                    edit: () async {
                                      Map editedData = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WillPopScope(
                                                    onWillPop: () async {
                                                      return false;
                                                    },
                                                    child: ShowItemDialog(
                                                      data: items[index],
                                                      factorsData:
                                                          widget.factors,
                                                      factorsLength:
                                                          widget.factors.length,
                                                    ),
                                                  ),
                                              fullscreenDialog: true));
                                      setState(() {
                                        items[index] = editedData;
                                        itemsDuplicate[index] = editedData;
                                      });
                                    },
                                    delete: () {
                                      setState(() {
                                        items.removeAt(index);
                                        itemsDuplicate.removeAt(index);
                                      });
                                    }));
                          }),
                    )
                  ],
                ),
                floatingActionButton: FabCircularMenu(
                    fabColor: Colors.red[800],
                    ringDiameter: MediaQuery.of(context).size.width * 0.5,
                    ringWidth: MediaQuery.of(context).size.width * 0.35 * 0.3,
                    fabSize: 60.0,
                    fabOpenIcon: Icon(Icons.add),
                    fabCloseColor: Color(0xffa239a0),
                    fabElevation: 5.0,
                    fabMargin: EdgeInsets.all(12.0),
                    ringColor: Colors.red[800],
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () async {
                            Map dialogData = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WillPopScope(
                                          onWillPop: () async {
                                            return false;
                                          },
                                          child: ShowItemDialog(
                                            factorsLength:
                                                widget.factors.length,
                                            factorsData: widget.factors,
                                            sliderValues: List<double>.filled(
                                                widget.factors.length, 0),
                                          ),
                                        ),
                                    fullscreenDialog: true));

                            setState(() {
                              items.add(dialogData);
                              itemsDuplicate.add(dialogData);
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            setState(() {
                              if (items.length > 0)
                                _isVisible = true;
                              else {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Row(children: <Widget>[
                                      Icon(
                                        Icons.warning,
                                        color: Colors.red[800],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                            'Please enter atleast one decision choice'),
                                      ),
                                    ]),
                                    elevation: 100.0,
                                    duration: Duration(seconds: 2)));
                              }
                            });
                          }),
                      Visibility(
                        visible: _isVisible,
                        child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Result(
                                          factors: widget.factors,
                                          items: items)));
                            }),
                      )
                    ]))));
  }
}
