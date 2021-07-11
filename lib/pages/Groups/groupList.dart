import 'package:flutter/material.dart';
import 'package:location_tracking_app/pages/Groups/groupProfile.dart';
import 'package:location_tracking_app/pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:location_tracking_app/Models/Group.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    final _grpList = Provider.of<List<Group>>(context);
    return ListView.builder(
        itemCount: _grpList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              // leading: Image.network(_cartList[index].imageUrl),
              title: Text(_grpList[index].grpName),
              subtitle: TextButton(
                child: Text('Group Info'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          GroupProfile(grp: _grpList[index])));
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          HomePage(grpDocId: _grpList[index].docId,)));
                },
              ),
              isThreeLine: true,
            ),
          );
        });
  }
}
