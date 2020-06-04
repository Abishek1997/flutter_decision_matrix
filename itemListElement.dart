import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hello/itemList.dart';

class ItemListElement extends StatelessWidget {
  final Map listObject;
  final int index;
  final Function edit;
  final Function delete;

  ItemListElement({this.listObject, this.index, this.edit, this.delete});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        elevation: 4.0,
        color: Color(0xff24292e),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(22.0, 5.0, 10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    this
                        .listObject['textFieldValue']
                        .toString()
                        .replaceFirst(
                            this.listObject['textFieldValue'][0],
                            this
                                .listObject['textFieldValue'][0]
                                .toString()
                                .toUpperCase()),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Color(0xffe5e7ea)),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          iconSize: 18.0,
                          icon: Icon(Icons.edit, color: Color(0xffe5e7ea)),
                          onPressed: edit))
                ],
              ),
            ),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: IconSlideAction(
            caption: 'Delete',
            color: Colors.red[800],
            icon: Icons.delete,
            onTap: delete,
          ),
        ),
      ],
    );
  }
}
