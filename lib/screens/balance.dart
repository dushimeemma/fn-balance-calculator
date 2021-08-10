import 'dart:ui';

import 'package:flutter/material.dart';

class Balance extends StatelessWidget {
  final double amount;
  final double amountPerDay;
  final int days;
  final double balance;

  Balance({
    required this.amount,
    required this.amountPerDay,
    required this.days,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Balance',
        textAlign: TextAlign.center,
        textScaleFactor: 2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: Theme.of(context).accentColor,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total : rwfs $amount',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Balance Per Day : rwfs $amountPerDay',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Days : $days days',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Balance : rwfs $balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(
              'close',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
