import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../models/http_exceptions.dart';

enum AuthState {
  initState,
  isLoading,
  isAuth,
  isError,
  isLoaded,
}

class Auth with ChangeNotifier {
  AuthState _initial_state = AuthState.initState;

  bool _isAuth = false;
  String _token = '';
  String _message = '';
  late final _user;

  AuthState get initial_state => _initial_state;

  String get token {
    return _token;
  }

  String get message {
    return _message;
  }

  User get user {
    return _user;
  }

  bool get isAuth {
    return _isAuth;
  }

  String url = 'https://balance-calculator-apis.herokuapp.com';

  Future<void> createUser(String name, String email, String password) async {
    _initial_state = AuthState.isLoading;

    try {
      await Future.delayed(
        Duration(
          seconds: 3,
        ),
      );
      final response = await http.post(
        Uri.parse('$url/api/auth/signup'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );
      _initial_state = AuthState.isLoaded;
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        _initial_state = AuthState.isError;
        throw HttpException(responseData['error']);
      }

      _message = responseData['message'];
      _user = responseData['user'];
      _token = responseData['token'];
      _isAuth = true;
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'user': _user,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      _initial_state = AuthState.isError;
      throw error;
    }
    _autoLogout();
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    _initial_state = AuthState.isLoading;

    try {
      await Future.delayed(
        Duration(
          seconds: 3,
        ),
      );
      final response = await http.post(
        Uri.parse('$url/api/auth/login'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      _initial_state = AuthState.isLoaded;
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        _initial_state = AuthState.isError;
        throw HttpException(responseData['error']);
      }

      _message = responseData['message'];
      _user = responseData['user'];
      _token = responseData['token'];
      _isAuth = true;

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'user': _user,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      _initial_state = AuthState.isError;
      throw error;
    }
    _autoLogout();
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        prefs.getString('userData') as Map<String, Object>;

    _token = extractedUserData['token'].toString();
    _user = extractedUserData['user'];
    _isAuth = true;

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = '';
    _user = null;
    _isAuth = false;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> _autoLogout() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      Timer(Duration(seconds: 3), logout);
    }
  }
}
