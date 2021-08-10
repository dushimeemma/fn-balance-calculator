import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exceptions.dart';
import './drawer.dart';
import '../providers/auth.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> _signup = {
    'name': '',
    'email': '',
    'password': '',
  };

  Future<void> _submit(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      await Provider.of<Auth>(context, listen: false).createUser(
        _signup['name'],
        _signup['email'],
        _signup['password'],
      );
      String message = Provider.of<Auth>(context, listen: false).message;
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
    AuthState state = Provider.of<Auth>(context, listen: true).initial_state;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Register',
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(
          64.0,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/balance-countdown-logo.png',
                  width: 100.0,
                  height: 100.0,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      child: Icon(
                        Icons.contacts_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(
                        0.0,
                      ),
                    ),
                    hintText: 'Example Name',
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name can\'t be null';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(
                      () {
                        _signup['name'] = value;
                      },
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      child: Icon(
                        Icons.email_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(
                        0.0,
                      ),
                    ),
                    hintText: 'email@email.example',
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _signup['email'] = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      child: Icon(
                        Icons.password_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: EdgeInsets.all(
                        0.0,
                      ),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is Too short';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(
                      () {
                        _signup['password'] = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => _submit(context),
                  child: state == AuthState.isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Register',
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
