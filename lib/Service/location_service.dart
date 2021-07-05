import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
String uid = _auth.currentUser!.uid;

class LocationService {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

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

  Map<MarkerId, Marker> _userListFromSnapshot(QuerySnapshot snapshot) {
    print("received first snapshot ${snapshot.docs.toString()}");
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

    snapshot.docs.forEach((doc) {
      print("it does reach here");
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print('data is ${data.toString()}');
      // return User(uid: uid);
      MarkerId markerId = MarkerId(data['uid']);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(data['location']['latitude'] as double,data['location']['longitude'] as double),
        infoWindow: InfoWindow(title: data['fname'], snippet: '*'),
        // onTap: () {
        //   _onMarkerTapped(markerId);
        // },
      );
      markers[markerId] = marker;
    });
    return markers;
  }

  Stream<Map<MarkerId, Marker>> get userMarks {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
