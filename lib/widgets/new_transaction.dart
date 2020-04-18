import 'package:expensetracker/widgets/adaptiveButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print("Constructor NewTransaction Widget");
  }

  @override
  _NewTransactionState createState() {
    print("createState NewTransaction Widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectDate;

  _NewTransactionState() {
    print("Constructor NewTransaction State");
  }

  @override
  void initState() {
    super.initState();
    print("initState()");
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget()");
  }

  @override
  void dispose() {
    //If the widget is removed
    // TODO: implement dispose
    super.dispose();
    print("dispose ()");
  }

  void _submitDate() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectDate);
    //widget will call the addTx function present in the NewTransaction class

    Navigator.of(context)
        .pop(); //Close the Top most sheet that is in display [Bottom Sheet]
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      //This function is called when the date is choosen
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  20), //To get above keyboard
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) =>
                    _submitDate(), // _ indicate that we don't care about this returned value

//                    onChanged: (val) {
//                      titleInput = val;
//                    },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.phone,
                onSubmitted: (_) => _submitDate(),
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectDate == null
                          ? 'No Date Choosen'
                          : 'Picked Date : ${DateFormat.yMMMd().format(_selectDate)}'),
                    ),
                    AdaptiveFlatButton("Choose Date", _showDatePicker)
                    //Custom Adaptive Button acc to OS
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Add Transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitDate,
              )
            ],
          ),
        ),
      ),
    );
  }
}
