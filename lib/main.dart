import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location_tracking_app/Service/Auth_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_tracking_app/pages/Authenticate/SignInPage.dart';
import 'package:location_tracking_app/pages/Authenticate/SignUpPage.dart';
import 'package:location_tracking_app/pages/Groups/groups.dart';
import 'package:location_tracking_app/pages/Groups/search.dart';
import 'package:location_tracking_app/pages/Profile/profilePage.dart';
import 'package:location_tracking_app/pages/wrapper.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthClass().user,
      child: MaterialApp(
        title: 'Location Tracking App',
        initialRoute: '/',
        routes: {
          '/': (context) =>Wrapper(),
          '/groups': (context) => Groups(),
          '/search' : (context) => Search(),
          '/login' : (context) => SignInPage(),
          '/signup' : (context) => SignUpPage(),
          '/profile':(context)=> ProfilePage(),
        },
      ),
    );
  }
}

