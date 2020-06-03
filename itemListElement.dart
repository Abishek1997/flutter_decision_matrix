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
        color: Colors.grey[800],
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
                    this.listObject['itemTextFieldValue'],
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          iconSize: 18.0,
                          icon: Icon(Icons.edit),
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
            color: Colors.red,
            icon: Icons.delete,
            onTap: delete,
          ),
        ),
      ],
    );
  }
}
