import 'package:flutter/material.dart';
import 'showDialog.dart';
import 'factorList.dart';
import 'itemList.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:getflutter/getflutter.dart';
import 'searchFunction.dart';
import 'drawerUI.dart';
import 'router.dart' as router;
import 'routingConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool seen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('seenIntro') != null) {
    seen = prefs.getBool('seenIntro');
  } else {
    prefs.setBool('seenIntro', true);
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      initialRoute:
          seen == false || seen == null ? IntroScreenViewRoute : HomeViewRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<ListDisplay> {
  List<Map> litems = [];
  List<Map> litemsDuplicate = [];

  bool _isVisible = false;
  final TextEditingController eCtrl = new TextEditingController();
  final TextEditingController searchTextController =
      new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    litems = [];
    litemsDuplicate = [];

    super.initState();
  }

  int count = 0;

  @override
  Widget build(BuildContext ctxt) {
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
              iconTheme: new IconThemeData(color: Color(0xff985EFF)),
              elevation: 3.0,
              searchBarColorTheme: Color(0xff985EFF),
              backgroundColor: Colors.grey[900],
              searchBar: true,
              searchHintText: 'Search factors..',
              searchController: searchTextController,
              onChanged: (text) {
                List<Map> returnData = SearchFunction()
                    .filterSearchResults(text, litems, litemsDuplicate);
                setState(() {
                  litems = returnData;
                });
              },
              searchHintStyle: TextStyle(color: Colors.white),
              title: Text(
                "Factors",
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
            body: Builder(
              builder: (context) => Container(
                color: Colors.grey[900],
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                        child: new ListView.builder(
                            itemCount: litems.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      1.0, 2.0, 1.0, 0.0),
                                  child: FactorList(
                                    listObject: litems[index],
                                    index: index,
                                    edit: () async {
                                      final Map editedData =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (context) => WillPopScope(
                                                            onWillPop:
                                                                () async {
                                                              return false;
                                                            },
                                                            child: showDialogMine(
                                                                textFieldValue:
                                                                    litems[index]
                                                                        [
                                                                        'textFieldValue'],
                                                                sliderValue: litems[
                                                                        index][
                                                                    'sliderNumValue'],
                                                                index: index),
                                                          )));

                                      setState(() {
                                        litems[index] = editedData;
                                        litemsDuplicate[index] = editedData;
                                      });
                                    },
                                    delete: () {
                                      setState(() {
                                        litems.removeAt(index);
                                        litemsDuplicate.removeAt(index);
                                      });
                                    },
                                  ));
                            })),
                  ],
                ),
              ),
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
                        final Map dialogData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WillPopScope(
                                    onWillPop: () async {
                                      return false;
                                    },
                                    child: showDialogMine())));
                        setState(() {
                          litems.add(dialogData);
                          litemsDuplicate.add(dialogData);
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.done),
                      onPressed: () {
                        setState(() {
                          if (litems.length > 0)
                            _isVisible = true;
                          else {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Row(children: <Widget>[
                                  Icon(
                                    Icons.warning,
                                    color: Colors.red[800],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child:
                                        Text('Please enter atleast one factor'),
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
                                  builder: (context) =>
                                      ItemList(factors: litems)));
                        }),
                  )
                ])),
      ),
    );
  }
}
