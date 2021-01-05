import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function adderFunk;

  NewTransaction(this.adderFunk);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _chosenDate;

  void _submitData() {

    if(_amountController.text.isEmpty) { return; }

    final inputTitle = _titleController.text;
    final inputAmount = double.parse(_amountController.text);
    final inputDate = _chosenDate;

    if (inputTitle.isEmpty || inputAmount <= 0 || _chosenDate == null) {
      return;
    }

    widget.adderFunk(inputTitle, inputAmount, inputDate);

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }

      _chosenDate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Card(
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              // this changes the 'submit' button type to an 'next arrow'
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              // this changes the 'submit' button type to an 'check arrow'
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              //onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _chosenDate == null
                          ? 'Please pick a date'
                          : DateFormat('d/M/y').format(_chosenDate),
                    ),
                  ),
                  FlatButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Theme.of(context).secondaryHeaderColor,
              color: Theme.of(context).accentColor,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
