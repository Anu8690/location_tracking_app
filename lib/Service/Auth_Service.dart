import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // stream for User type data
  Stream<User?> get user {
    return _auth.authStateChanges().map((user) {
      return user;
    });
  }

  Future<void> signOut({BuildContext? context}) async {
    try {
      await _auth.signOut();
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
