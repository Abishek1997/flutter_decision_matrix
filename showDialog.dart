import 'package:flutter/material.dart';

class showDialogMine extends StatefulWidget {
  final String textFieldValue;
  final double sliderValue;
  final int index;

  showDialogMine({this.textFieldValue, this.sliderValue, this.index}) {}

  @override
  _showDialogMineState createState() => _showDialogMineState();
}

class _showDialogMineState extends State<showDialogMine> {
  double _value = 0;
  List<String> tooltipValues = ['Low', 'Medium', 'High'];
  String textFieldString = '';
  int index = -1;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    if (widget.textFieldValue != null) {
      textEditingController.text = widget.textFieldValue;
    }
    if (widget.sliderValue == null) {
      _value = 0;
    } else {
      _value = widget.sliderValue;
    }

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
            minimum: const EdgeInsets.all(10.0),
            child: new Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.black,
                body: Container(
                    child: FractionallySizedBox(
                        widthFactor: MediaQuery.of(context).size.width * 0.9,
                        child: Column(children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: TextField(
                                controller: textEditingController,
                                enableInteractiveSelection: true,
                                maxLength: 25,
                                autofocus: false,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "Enter your item here.."),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
                            child: Text(
                              'Enter the priority for your factor',
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Colors.red[700],
                                          inactiveTrackColor: Colors.red[100],
                                          trackShape:
                                              RoundedRectSliderTrackShape(),
                                          trackHeight: 4.0,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 12.0),
                                          thumbColor: Colors.redAccent,
                                          overlayColor:
                                              Colors.red.withAlpha(32),
                                          overlayShape: RoundSliderOverlayShape(
                                              overlayRadius: 28.0),
                                          tickMarkShape:
                                              RoundSliderTickMarkShape(),
                                          activeTickMarkColor: Colors.red[700],
                                          inactiveTickMarkColor:
                                              Colors.red[100],
                                          valueIndicatorShape:
                                              PaddleSliderValueIndicatorShape(),
                                          valueIndicatorColor: Colors.redAccent,
                                          valueIndicatorTextStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Slider(
                                          value: _value,
                                          min: 0,
                                          max: 2,
                                          divisions: 2,
                                          label:
                                              '${tooltipValues[_value.round()]}',
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                _value = value;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: IconButton(
                                        icon: Icon(Icons.send),
                                        onPressed: () {
                                          Navigator.pop(context, {
                                            "sliderValue":
                                                tooltipValues[_value.round()],
                                            "textFieldValue":
                                                textEditingController.text,
                                            "sliderNumValue": _value,
                                          });
                                        }),
                                  )
                                ],
                              )),
                        ]))))));
  }
}
