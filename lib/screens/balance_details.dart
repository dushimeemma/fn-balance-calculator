import 'package:flutter/material.dart';

class BalanceDetails extends StatelessWidget {
  static const routeName = '/balance-details';
  final String title;
  final double amount;
  final double amountPerDay;
  final int days;
  final double balance;

  BalanceDetails({
    this.title = 'Update Per Day',
    this.amount = 45000,
    this.amountPerDay = 3000,
    this.days = 15,
    this.balance = 45000,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(
          10.0,
        ),
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 35.0,
              ),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(
                    16.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.remove_rounded,
                        ),
                      ),
                      Text(
                        '15',
                        textAlign: TextAlign.center,
                        textScaleFactor: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(
                  16.0,
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
