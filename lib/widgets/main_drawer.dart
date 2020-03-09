import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer();

  ListTile buildListTile({
    @required String title,
    @required IconData icon,
    @required Function tapHandler,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Coocking Up!",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            title: 'Meals',
            icon: Icons.restaurant,
            tapHandler: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          buildListTile(
            title: 'Settings',
            icon: Icons.settings,
            tapHandler: () => Navigator.of(context)
                .pushReplacementNamed(FiltersScreen.routeName),
          ),
        ],
      ),
    );
  }
}
