import 'package:flutter/material.dart';
import 'showDialog.dart';
import 'factorList.dart';
import 'itemList.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      home: new ListDisplay(),
    );
  }
}

class ListDisplay extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<ListDisplay> {
  List<Map> litems = [];
  bool _isVisible = false;
  final TextEditingController eCtrl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    litems = [];
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
        minimum: const EdgeInsets.all(10.0),
        child: new Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[900],
            body: new Column(
              children: <Widget>[
                new Expanded(
                    child: new ListView.builder(
                        itemCount: litems.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: FactorList(
                                listObject: litems[index],
                                index: index,
                                edit: () async {
                                  final Map editedData = await showDialog<Map>(
                                    context: context,
                                    builder: (context) => showDialogMine(
                                        textFieldValue: litems[index]
                                            ['textFieldValue'],
                                        sliderValue: litems[index]
                                            ['sliderNumValue'],
                                        index: index),
                                  );
                                  setState(() {
                                    litems[index] = editedData;
                                  });
                                },
                                delete: () {
                                  setState(() {
                                    litems.removeAt(index);
                                  });
                                },
                              ));
                        })),
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
                        final Map dialogData = await showDialog<Map>(
                          context: context,
                          builder: (context) => showDialogMine(),
                        );
                        setState(() {
                          litems.add(dialogData);
                        });
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
