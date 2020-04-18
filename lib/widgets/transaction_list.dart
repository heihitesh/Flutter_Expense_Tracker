import 'package:expensetracker/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constrants) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Transaction Added Yet",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: constrants.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              //Similar like RecyclerView
              itemBuilder: (ctx, indexOfItem) {
                //Add All the list Items
                return TransactionItem(
                    key: ValueKey(transactions[indexOfItem].id),
                    //Every new Item list will get a Unique key provided by Dev
                    transactions: transactions[indexOfItem],
                    deleteTransaction: deleteTransaction);
              },
              itemCount: transactions.length,
            ),
    );
  }
}
