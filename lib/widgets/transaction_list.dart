import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './slidable_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> trList;
  final Function removeFunk;

  TransactionList(this.trList, this.removeFunk);

  @override
  Widget build(BuildContext context) {
    return trList.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions here! Try adding one.',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20),
              Container(
                height: 300,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
                elevation: 2,
                child: SlidableItem(
                  iconActionsList: [
                    {
                      'actionName': 'Show more',
                      'actionFunction': () {},
                      'icon': Icons.more_horiz,
                      'color': Theme.of(context).accentColor
                    },
                    {
                      'actionName': 'Delete',
                      'actionFunction': () => removeFunk(trList[index]),
                      'icon': Icons.delete,
                      'color': Colors.red
                    }
                  ],
                  itemAmount: trList[index].amount,
                  itemDate: DateFormat('E, d/M/y').format(trList[index].date),
                  itemTitle: trList[index].title,
                ),
              );
              // ListTile(
              //   leading: CircleAvatar(
              //     radius: 30,
              //     child: Padding(
              //       padding: EdgeInsets.all(8),
              //       child: FittedBox(
              //         child: Text(
              //           '\$${trList[index].amount.toStringAsFixed(2)}',

              //         )
              //       )
              //     ),
              //   ),
              //   title: Text(
              //     trList[index].title,
              //     style: Theme.of(context).textTheme.headline6,
              //   ),
              //   subtitle: Text(
              //     DateFormat('E, d/M/y').format(trList[index].date),
              //     style: Theme.of(context).textTheme.subtitle2,
              //   ),
              //   trailing: IconButton(
              //     icon: Icon(Icons.delete),
              //     onPressed: () => removeFunk(trList[index]),
              //   ),
              // );

              // return Card(
              //   color: Theme.of(context).cardColor,
              //   shadowColor: Theme.of(context).cardTheme.shadowColor,
              //   elevation: 5,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Container(
              //         margin:
              //             EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColorDark,
              //             width: 2.0,
              //           ),
              //         ),
              //         padding: EdgeInsets.all(10.0),
              //         child: Text(
              //           '\$${trList[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20.0,
              //             color: Theme.of(context).primaryColorDark,
              //           ),
              //         ),
              //       ),
              //       Flexible(
              //         fit: FlexFit.tight,
              //         child: Padding(
              //           padding: const EdgeInsets.only(right: 20.0),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               FittedBox(
              //                 child: Text(
              //                   trList[index].title,
              //                   style: Theme.of(context).textTheme.headline6,
              //                 ),
              //               ),
              //               Text(
              //                 //'${e.date.day}/${e.date.month}/${e.date.year} - ${e.date.hour}:${e.date.minute}',
              //                 DateFormat.yMMMMd().format(trList[index].date),
              //                 style: TextStyle(
              //                   color: Colors.blueGrey,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
            itemCount: trList.length,
          );
  }
}
