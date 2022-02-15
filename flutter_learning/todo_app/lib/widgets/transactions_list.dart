// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(children: [
              Text(
                "No data",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Image.asset(
                  "images/waiting.png",
                  fit: BoxFit.cover,
                ),
                height: constrains.maxHeight * 0.8,
              ),
            ]);
          })
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      transaction: tx,
                      deleteTx: deleteTx,
                      key: ValueKey(tx.id),
                    ))
                .toList(),
          );
  }
}
