import 'package:flutter/material.dart';

class ShowItemDialog extends StatefulWidget {
  final List<Map> factorsData;
  final int factorsLength;
  final List<double> sliderValues;
  final Map data;

  ShowItemDialog(
      {this.data, this.factorsLength, this.factorsData, this.sliderValues}) {}
  @override
  _ShowItemDialogState createState() => _ShowItemDialogState();
}

class _ShowItemDialogState extends State<ShowItemDialog> {
  final TextEditingController textEditingController = TextEditingController();

  List<String> tooltipValues = ['Very Poor', 'Poor', 'Okay', 'Good', 'Best'];

  List<double> sliderValuesToSet = [];

  @override
  void initState() {
    // TODO: implement initState

    if (widget.data != null) {
      textEditingController.text = widget.data['textFieldValue'];
      sliderValuesToSet = widget.data['sliderValuesArray'];
    } else {
      sliderValuesToSet = List<double>.filled(widget.factorsLength, 0);
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
                              'Rate your item based on each factor below',
                              style: TextStyle(
                                  fontSize: 17.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Card(
                                color: Colors.black,
                                child: ListView.builder(
                                    itemCount: widget.factorsLength,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Text(
                                                    widget.factorsData[index]
                                                        ['textFieldValue'],
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: SliderTheme(
                                                      data: SliderTheme.of(
                                                              context)
                                                          .copyWith(
                                                        activeTrackColor:
                                                            Colors.red[700],
                                                        inactiveTrackColor:
                                                            Colors.red[100],
                                                        trackShape:
                                                            RoundedRectSliderTrackShape(),
                                                        trackHeight: 4.0,
                                                        thumbShape:
                                                            RoundSliderThumbShape(
                                                                enabledThumbRadius:
                                                                    12.0),
                                                        thumbColor:
                                                            Colors.redAccent,
                                                        overlayColor: Colors.red
                                                            .withAlpha(32),
                                                        overlayShape:
                                                            RoundSliderOverlayShape(
                                                                overlayRadius:
                                                                    28.0),
                                                        tickMarkShape:
                                                            RoundSliderTickMarkShape(),
                                                        activeTickMarkColor:
                                                            Colors.red[700],
                                                        inactiveTickMarkColor:
                                                            Colors.red[100],
                                                        valueIndicatorShape:
                                                            PaddleSliderValueIndicatorShape(),
                                                        valueIndicatorColor:
                                                            Colors.redAccent,
                                                        valueIndicatorTextStyle:
                                                            TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      child: Slider(
                                                        value:
                                                            sliderValuesToSet[
                                                                index],
                                                        min: 0,
                                                        max: 4,
                                                        divisions: 4,
                                                        label:
                                                            '${tooltipValues[sliderValuesToSet[index].round()]}',
                                                        onChanged: (value) {
                                                          setState(
                                                            () {
                                                              sliderValuesToSet[
                                                                      index] =
                                                                  value;
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                List<String> sliderStringArray = [];

                                sliderValuesToSet.forEach((element) {
                                  sliderStringArray
                                      .add(tooltipValues[element.round()]);
                                });

                                Navigator.pop(context, {
                                  "textFieldValue": textEditingController.text,
                                  "sliderValuesArray": sliderValuesToSet,
                                  "sliderStringArray": sliderStringArray
                                });
                              })
                        ]))))));
  }
}
