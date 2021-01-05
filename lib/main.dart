import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import 'package:google_fonts/google_fonts.dart';
import './widgets/chart.dart';

// IDEA: app tells you what you could have bought with the amount spent on each item
// IDEA 2: pantry administrator where you set how much you need from each item and the
// makes you a shopping list for groceries
// IDEA 2: RPG character stats controller or RPG resources controller
// idea: ecommerce app where you visualize the products as an story like instagram

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Know your expenses',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.indigo,
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme)
            .copyWith(
          headline6: TextStyle(
            fontSize: 18.0,
            fontFamily: GoogleFonts.rubik().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        //fontFamily: 'Quicksand',
        // textTheme: ThemeData.light().textTheme.copyWith(
        //   headline6: TextStyle(
        //     fontFamily: 'OpenSans',
        //     fontWeight: FontWeight.bold,
        //     fontSize: 18.0,
        //   ),
        // ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'transa1',
      title: 'Sm7b Shure Mic',
      amount: 3499.99,
      date: DateTime(2020, 12, 8, 17, 30),
    ),
    Transaction(
      id: 'transa2',
      title: 'Rickenbacker red bass',
      amount: 4999.99,
      date: DateTime(2020, 12, 6, 17, 30),
    )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(
          days: 7,
        ),
      ));
    }).toList();
  }

  void _addNewTransaction(String addTitle, double addAmount, DateTime addDate) {
    final newTr = Transaction(
      title: addTitle,
      amount: addAmount,
      date: addDate,
      id: DateTime.now().millisecond.toString(),
    );

    print(newTr.id);

    setState(() {
      _userTransactions.add(newTr);
    });
  }

  void _deleteTransaction(Transaction t) {
    setState(() {
      _userTransactions.remove(t);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _showSideMenu(BuildContext ctx) {
    showMenu(
      context: ctx,
      position: RelativeRect.fill,
      items: <PopupMenuItem<String>>[
        const PopupMenuItem<String>(child: Text('test1'), value: 'test1'),
        const PopupMenuItem<String>(child: Text('test2'), value: 'test2'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        icon: Icon(Icons.toc_rounded),
        onPressed: () => _showSideMenu(context),
        iconSize: 40,
      ),
      title: Text('Know your expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Chart(_recentTransactions),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height-MediaQuery.of(context).padding.top) *
                  0.3,
            ),
            Container(
              child: TransactionList(_userTransactions, _deleteTransaction),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height-MediaQuery.of(context).padding.top) *
                  0.7,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
