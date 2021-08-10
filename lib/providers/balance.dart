import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exceptions.dart';

enum BalanceState {
  initState,
  isLoading,
  isError,
  isLoaded,
}

class BalanceProvider with ChangeNotifier {
  BalanceState _init_state = BalanceState.initState;
  String _message = '';
  List<dynamic> _balances = [];
  final String token;

  BalanceProvider(this.token, this._balances);

  BalanceState get initial_state => _init_state;

  String get message {
    return _message;
  }

  List<dynamic> get balances {
    return [..._balances];
  }

  String url = 'https://balance-calculator-apis.herokuapp.com';

  Future<void> getAllBalances() async {
    _init_state = BalanceState.isLoading;

    try {
      await Future.delayed(
        Duration(
          seconds: 3,
        ),
      );
      final response = await http.get(
        Uri.parse('$url/api/balance'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'x-auth-token': token,
        },
      );
      final responseData = json.decode(response.body);
      _init_state = BalanceState.isLoaded;
      if (responseData['error'] != null) {
        _init_state = BalanceState.isError;
        throw HttpException(responseData['error']);
      }
      _balances = responseData['balances'];
      _message = responseData['message'];
      notifyListeners();
    } catch (error) {
      _init_state = BalanceState.isError;
      throw error;
    }
  }

  Future<void> createBalance(
    double amount,
    double amountPerDay,
  ) async {
    _init_state = BalanceState.isLoading;
    try {
      await Future.delayed(
        Duration(
          seconds: 3,
        ),
      );
      final response = await http.post(
        Uri.parse('$url/api/balance'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'x-auth-token': token,
        },
        body: json.encode(
          {
            'amount': amount,
            'amount_per_day': amountPerDay,
          },
        ),
      );
      final responseData = json.decode(response.body);
      _init_state = BalanceState.isLoaded;
      if (responseData['error'] != null) {
        _init_state = BalanceState.isError;
        throw HttpException(responseData['error']);
      }
      _message = responseData['message'];
    } catch (error) {
      _init_state = BalanceState.isError;
      throw error;
    }
  }
}
