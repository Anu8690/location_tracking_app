import 'package:flutter/material.dart';
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
              subtitle: Text(''),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  // got ot the map representing the grp
                },
              ),
              isThreeLine: true,
            ),
          );
        });
  }
}
