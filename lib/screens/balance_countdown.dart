import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './balance.dart';
import './balance_details.dart';
import './drawer.dart';
import '../widgets/card.dart';
import '../providers/balance.dart';
import '../models/http_exceptions.dart';

class BalanceCountDown extends StatefulWidget {
  static const routeName = '/balance-countdown';

  @override
  _BalanceCountDownState createState() => _BalanceCountDownState();
}

class _BalanceCountDownState extends State<BalanceCountDown> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> _balance = {
    'amount': '',
    'amount_per_day': '',
  };

  var _isInit = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<BalanceProvider>(context, listen: true).getAllBalances();
    }
    super.didChangeDependencies();
  }

  Future<void> _createBalance(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      await Provider.of<BalanceProvider>(context, listen: false).createBalance(
        double.parse(_balance['amount']),
        double.parse(_balance['amount_per_day']),
      );
      String message =
          Provider.of<BalanceProvider>(context, listen: false).message;
      if (message != '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            action: SnackBarAction(
              label: 'x',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      }
    } on HttpException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          action: SnackBarAction(
            label: 'x',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            'an error occured',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          action: SnackBarAction(
            textColor: Colors.red,
            label: 'x',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final balances = Provider.of<BalanceProvider>(context).balances;
    BalanceState state = Provider.of<BalanceProvider>(context).initial_state;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Balance Countdown',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
            40.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      child: Icon(
                        Icons.money_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(
                        0.0,
                      ),
                    ),
                    hintText: 'Enter amount',
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Balance can\'t be null';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(
                      () {
                        _balance['amount'] = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      child: Icon(
                        Icons.money_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(
                        0.0,
                      ),
                    ),
                    hintText: 'Enter amount per day',
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Amount per day can\'t be null';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(
                      () {
                        _balance['amount_per_day'] = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => _createBalance(context),
                  child: state == BalanceState.isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Save',
                        ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Available Balance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                (balances.length > 0)
                    ? CustomCard(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            BalanceDetails.routeName,
                          );
                        },
                      )
                    : Text(
                        'Create a Balance',
                      ),
                SizedBox(
                  height: 40.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => Balance(
                        amount: 45000,
                        amountPerDay: 3000,
                        balance: 45000,
                        days: 15,
                      ),
                    );
                  },
                  child: Text(
                    'View Balance',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
