import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double amount;
  final double amountPerDay;
  final int days;
  final dynamic onTap;

  CustomCard({
    this.amount = 45000,
    this.amountPerDay = 3000,
    this.days = 15,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(
          32.0,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Amount : rwfs $amount',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Amount Per Day: rwfs $amountPerDay',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Days: $days days',
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
    );
  }
}
