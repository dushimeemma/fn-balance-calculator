import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final dynamic onTap;
  final IconData icon;

  CustomListTile({
    required this.title,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
