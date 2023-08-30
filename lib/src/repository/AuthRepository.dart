import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healtyfy/src/feature/auth/view/login.dart';

import '../healtyfy.dart';
import '../utils/Snackbar.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbReference = FirebaseDatabase.instance.ref();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();
  String filesImage = '';

  Future<String> signInWithEmailAndPassword(
      GlobalKey key, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      final userUid = _auth.currentUser?.uid;
      final snapshot = await _dbReference.child('users').child(userUid!).get();

      if (snapshot.exists) {
        User? user = _auth.currentUser;
        user?.updateDisplayName(snapshot.child('username').value.toString());
      }

      Navigator.pushReplacement(
        key.currentState!.context,
        MaterialPageRoute(builder: (context) => Healtyfy()),
      );
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return 'success';
  }

  Future<String> signUpWithEmailAndPassword(
      GlobalKey key, String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _dbReference.child("users").child(userCredential.user!.uid).set(
            {'username': username, 'email': email, 'score': 0, 'photo': ''});

        User? user = _auth.currentUser;
        user?.updateDisplayName(username);
      }

      Navigator.pushReplacement(
        key.currentState!.context,
        MaterialPageRoute(builder: (context) => Healtyfy()),
      );
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return 'success';
  }

  Future<void> signOut(GlobalKey key) async {
    await _auth.signOut().whenComplete(
      () {
        Navigator.pushReplacement(
          key.currentState!.context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      },
    );
  }

  Future<String> fetchUserImage(GlobalKey key, String path) async {
    try {
      if (path != '') {
        String file =
            await storage.ref().child('users').child(path).getDownloadURL();
        filesImage = file;
      }
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    } catch (e) {
      debugPrint('$e');
    }
    return filesImage;
  }
}
