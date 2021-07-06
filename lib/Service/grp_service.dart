import 'package:location_tracking_app/Models/Group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupService{
  CollectionReference grpCollection =
      FirebaseFirestore.instance.collection('groups');

  List<Group> _grpListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Group(grpName: data['grpName'],userUidList: data['userUidList']);
    }).toList();
  }
  Stream<List<Group>> get groups {
    return grpCollection.snapshots().map(_grpListFromSnapshot);
  }
}