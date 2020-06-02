import 'package:flutter/material.dart';
import 'showDialog.dart';
import 'factorList.dart';

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
            appBar: AppBar(
              title: Text('Decision Matrix'),
              backgroundColor: Colors.red[500],
              toolbarOpacity: 0.75,
            ),
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
                                    print('index is, $index');
                                    litems.removeAt(index);
                                    print('after delete, $litems\n');
                                  });
                                },
                              ));
                        })),
              ],
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red[500],
                child: Icon(Icons.add),
                onPressed: () async {
                  final Map dialogData = await showDialog<Map>(
                    context: context,
                    builder: (context) => showDialogMine(),
                  );
                  setState(() {
                    litems.add(dialogData);

                    print('data JSON is, $litems');
                  });
                })),
      ),
    );
  }
}
