import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_tracking_app/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:geolocator/geolocator.dart';

auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
String uid = _auth.currentUser!.uid;

class LocationService {
  CollectionReference grpuserCollectionRef = FirebaseFirestore.instance
      .collection('groups')
      .doc('grp1')
      .collection('users');
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return User(uid: uid);
    }).toList();
  }

  Stream<List<User>> get users {
    return grpuserCollectionRef.snapshots().map(_userListFromSnapshot);
  }

  Future<Position> getAndUpdateCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // print('started');
    Position currentPosiition = await Geolocator.getCurrentPosition();
    // print('started got location');
    String uid = _auth.currentUser!.uid;
    await userCollection.doc(uid).set({
      'location': {
        'longitude': currentPosiition.longitude,
        'latitude': currentPosiition.latitude,
      }
    }, SetOptions(merge: true));
    // print('started uploaded location');
    return currentPosiition;
  }
}
