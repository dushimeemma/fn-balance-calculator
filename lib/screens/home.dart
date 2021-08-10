import 'dart:async';

import 'package:flutter/material.dart';

import './balance_countdown.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(
        seconds: 3,
      ),
      () => Navigator.of(context).pushNamed(
        BalanceCountDown.routeName,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Image.asset(
          'assets/images/balance-countdown-logo.png',
          width: 195.0,
          height: 162.0,
        ),
      ),
    );
  }
}
