import 'package:location_tracking_app/Service/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:location_tracking_app/pages/Profile/profilePage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  int _selectedDestination = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerBar(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authClass.signOut();
              }),
        ],
      ),
    );
  }

  Widget drawerBar() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 0, 5),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Profile'),
            selected: _selectedDestination == 0,
            onTap: () {
              selectDestination(0);
              Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Product'),
            selected: _selectedDestination == 1,
            onTap: () => selectDestination(1),
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text('Generate Bill'),
            selected: _selectedDestination == 2,
            onTap: () {
              selectDestination(2);
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Account settings',
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            selected: _selectedDestination == 3,
            onTap: () {
              selectDestination(3);
              authClass.signOut();
            },
          ),
        ],
      ),
    );
  }
  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
