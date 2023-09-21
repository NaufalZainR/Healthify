import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/Snackbar.dart';

class SayaRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  Future<void> uploadPhoto(BuildContext context) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage =
          await picker.pickImage(source: ImageSource.gallery, maxWidth: 1920);

      File imageFile = File(pickedImage!.path);

      try {
        final fileName = '${auth.currentUser!.uid}.png';
        await dbReference
            .child('users')
            .child(auth.currentUser!.uid)
            .child('photo')
            .set(fileName);
        await storage.ref().child('users').child(fileName).putFile(imageFile);

        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Berhasil'),
              content: const Text('Berhasil mengganti foto!'),
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
        Snackbar.snackbarShow(context, '$e');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> changeUsername(BuildContext context, String usernameNew) async {
    try {
      await dbReference
          .child('users')
          .child(auth.currentUser!.uid)
          .child('username')
          .set(usernameNew);

      User? user = auth.currentUser;
      user?.updateDisplayName(usernameNew);

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text('Berhasil mengganti nama!'),
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
      Snackbar.snackbarShow(context, '$e');
    }
  }
}
