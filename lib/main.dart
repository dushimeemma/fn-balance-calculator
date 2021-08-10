import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/balance.dart';
import './screens/balance_countdown.dart';
import './screens/home.dart';
import './screens/balance_details.dart';
import './screens/register.dart';
import './screens/login.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, BalanceProvider>(
          create: (_) => BalanceProvider('', []),
          update: (ctx, auth, previousBalances) => BalanceProvider(
            auth.token,
            previousBalances!.balances,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Balance Calculator',
          theme: ThemeData(
            primaryColor: Color(0xFF249225),
            accentColor: Color(0xFF0275d8),
          ),
          home: auth.isAuth ? MyHomePage() : Login(),
          routes: {
            BalanceCountDown.routeName: (context) => BalanceCountDown(),
            BalanceDetails.routeName: (context) => BalanceDetails(),
            Register.routeName: (context) => Register(),
            Login.routeName: (context) => Login(),
          },
        ),
      ),
    );
  }
}
