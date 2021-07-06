import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchQuery = TextEditingController();
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  List<String> _searchedUsernames = <String>[];

  void _searchUsernameInDatabase(String text) async {
    List<String> result = <String>[];
    QuerySnapshot snapshot =
        await userCollection.where('fname', isEqualTo: text).get();
    snapshot.docs.forEach((doc) {
      result.add(doc['fname']);
    });
    setState(() {
      _searchedUsernames = result;
    });
    print(_searchedUsernames.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        // create grp
      }),
      appBar: AppBar(
        title: Text('Create Group'),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _searchQuery,
              autofocus: true,
              decoration: InputDecoration(
                // add more decoration
                hintText: 'Search by username',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              onChanged: _searchUsernameInDatabase,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _searchedUsernames.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.label),
                      title: Text(_searchedUsernames[index]),
                      // selected: _selectedDestination == 2,
                      onTap: () {
                        
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
