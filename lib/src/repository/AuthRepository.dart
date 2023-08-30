import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healtyfy/src/feature/auth/view/login.dart';

import '../healtyfy.dart';
import '../utils/Snackbar.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbReference = FirebaseDatabase.instance.ref();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();
  String filesImage = '';

  Future<void> signInWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      final userUid = _auth.currentUser?.uid;
      final snapshot = await _dbReference.child('users').child(userUid!).get();

      if (snapshot.exists) {
        User? user = _auth.currentUser;
        user?.updateDisplayName(snapshot.child('username').value.toString());
      }

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text(
              'Berhasil login!'
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Oke"))
            ],
          );
        },
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Healtyfy()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Email atau kata sandi anda salah!'
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Oke"))
              ],
            );
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    late final credential;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      if(userCredential.additionalUserInfo!.isNewUser){
        await _dbReference.child("users").child(userCredential.user!.uid).set({
          'username':userCredential.user!.displayName,
          'email':userCredential.user!.email,
          'score':0,
          'photo':''
        });

        User? user = _auth.currentUser;
        user?.updateDisplayName(credential.user!.displayName);
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Healtyfy()));
    } on FirebaseAuthException catch (e) {
      return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              '$e'
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Oke"))
            ],
          );
        },
      );
    } catch (e) {
      debugPrint('$e');
    }
    return await _auth.signInWithCredential(credential);
  }

  Future<String> signUpWithEmailAndPassword(BuildContext context, String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if(userCredential.user != null){
        await _dbReference.child("users").child(userCredential.user!.uid).set({
          'username':username,
          'email':email,
          'score':0,
          'photo':''
        });

        User? user = _auth.currentUser;
        user?.updateDisplayName(username);
      }

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text(
              'Berhasil mendaftar!'
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Oke"))
            ],
          );
        },
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Healtyfy()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Email sudah digunakan!'
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Oke"))
              ],
            );
          },
        );
      }
    }
    return 'success';
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text(
              'Berhasil keluar!'
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Oke"))
            ],
          );
        },
      );

      await _auth.signOut().whenComplete(() => Navigator.popUntil(context, ModalRoute.withName("/")));
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(context, '$e');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> fetchUserImage(GlobalKey key, String path) async {
    try{
      if (path != '') {
        String file = await storage.ref().child('users').child(path).getDownloadURL();
        filesImage = file;
      }
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    } catch (e) {
      debugPrint('$e');
    }
    return filesImage;
  }

  Future<void> forgotPass(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text(
              'Berhasil mengirimkan email reset kata sandi!'
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Oke"))
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Email tidak terdaftar!'
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Oke"))
              ],
            );
          },
        );
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}