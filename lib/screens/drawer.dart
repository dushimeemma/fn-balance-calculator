import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/list_drawer.dart';
import './register.dart';
import './login.dart';
import './balance_countdown.dart';
import '../providers/auth.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isAuth = Provider.of<Auth>(context, listen: false).isAuth;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/balance-countdown-logo.png',
                  width: 95.0,
                  height: 62.0,
                ),
                Text(
                  'Balance Countdown',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          isAuth ? AuthRow() : GuestRow(),
        ],
      ),
    );
  }
}

class AuthRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          title: 'Home',
          icon: Icons.home_rounded,
          onTap: () {
            Navigator.of(context).pushNamed(BalanceCountDown.routeName);
          },
        ),
        CustomListTile(
          title: 'Logout',
          icon: Icons.logout_rounded,
          onTap: () {
            Timer(
              Duration(
                seconds: 3,
              ),
              () => Navigator.of(context).pop(),
            );
          },
        ),
      ],
    );
  }
}

class GuestRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          title: 'Home',
          icon: Icons.home_rounded,
          onTap: () {
            Navigator.of(context).pushNamed(BalanceCountDown.routeName);
          },
        ),
        CustomListTile(
          title: 'Register',
          icon: Icons.app_registration_rounded,
          onTap: () {
            Navigator.of(context).pushNamed(Register.routeName);
          },
        ),
        CustomListTile(
          title: 'Login',
          icon: Icons.login_rounded,
          onTap: () {
            Navigator.of(context).pushNamed(Login.routeName);
          },
        ),
      ],
    );
  }
}
