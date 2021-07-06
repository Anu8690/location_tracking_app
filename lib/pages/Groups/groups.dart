import 'package:flutter/material.dart';
import 'package:location_tracking_app/Service/grp_service.dart';
import 'package:location_tracking_app/pages/Groups/groupList.dart';
import 'package:location_tracking_app/pages/Groups/search.dart';
import 'package:provider/provider.dart';
import 'package:location_tracking_app/Models/Group.dart';
class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Group>>.value(
      initialData:[],
      value: GroupService().groups,
          child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Search()));
        }),
        appBar: AppBar(
          title: Text('Groups'),
        ),
        body: GroupList(),
      ),
    );
  }
}
