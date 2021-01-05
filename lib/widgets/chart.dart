import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

// 8499,98

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index){
      final weekDay  = DateTime.now().subtract(Duration(days: index));
      var dayAmount = recentTransactions.fold(0.0, (prev, element) {
        return (element.date.day == weekDay.day && 
                element.date.month == weekDay.month && 
                element.date.year == weekDay.year) ?
                prev + element.amount : 
                prev;
      });
      print(DateFormat.E().format(weekDay));
      print(dayAmount);
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'amount': dayAmount,
      };
    }).reversed.toList();
  }

  double get weekTotalExpenditure {
    return groupedTransactionsValues.fold(
      0.0, (previousValue, element) => previousValue + element['amount']
    );
  }


  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'], 
                e['amount'], 
                weekTotalExpenditure == 0.0 ? 0.0 : (e['amount'] as double)/weekTotalExpenditure
              ),
            );
          }).toList(),
        ),
      ),
      
    );
  }
}