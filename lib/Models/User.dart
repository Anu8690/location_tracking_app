import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
FirebaseAuth _auth = FirebaseAuth.instance;

class User {
  static const tempUserImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/location-tracking-app-9cfc4.appspot.com/o/user.jpg?alt=media&token=3701e1b3-5ce7-474f-9d62-25106d6995f6";
  final String uid;
  final String? name;
  final String? imageUrl;
  final String? longitude;
  final String? latitude;
  User({required this.uid, this.name = '', this.imageUrl = tempUserImageUrl, this.longitude = '',this.latitude = ''});

  Future addUser() async {
    assert(_auth.currentUser != null);
    String uid = _auth.currentUser!.uid;
    String? name = _auth.currentUser!.displayName;
    String? imageUrl = _auth.currentUser!.photoURL;
    imageUrl ??= this.imageUrl;
    name ??= this.name;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot documentSnapshot = await users.doc(uid).get();
    if (!documentSnapshot.exists) {
      try {
        await users.doc(uid).set({
          'uid': uid,
          'fname': name,
          'imageUrl': imageUrl,
        },SetOptions(merge: true));
        // print("user added to databse");
      } catch (e) {
        // for if some error occured
        print(e);
      }
    }
  }
}
