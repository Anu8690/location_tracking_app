import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  final String grpName;
  final List<dynamic> userUidList;
  Group({required this.grpName, required this.userUidList});

  CollectionReference grpRef = FirebaseFirestore.instance.collection('groups');
  Future<void> createGrp() async {
    await grpRef.add({
      'grpName' : grpName,
      'userUidList' : userUidList,
    });
  }
}
