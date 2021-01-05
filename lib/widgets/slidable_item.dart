import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class SlidableItem extends StatelessWidget {
  final List<Map<String, Object>> iconActionsList;
  final String itemTitle;
  final String itemDate;
  final double itemAmount;

  SlidableItem(
      {this.iconActionsList, this.itemTitle, this.itemDate, this.itemAmount});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: FittedBox(
                child: Text(
                  '\$${itemAmount.toStringAsFixed(2)}',
                ),
              ),
            ),
          ),
          title: Text(
            itemTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            itemDate,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
      secondaryActions: iconActionsList.map((e) {
        return IconSlideAction(
          caption: e['actionName'],
          icon: e['icon'],
          color: e['color'],
          onTap: e['actionFunction'],
        );
      }).toList(),
    );
  }
}
