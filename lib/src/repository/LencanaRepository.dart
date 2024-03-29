import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtyfy/src/feature/tantangan/model/LencanaModel.dart';

import '../utils/Snackbar.dart';

class LencanaRepository{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<LencanaModel> listLencana = [];
  String filesImage = '';
  List userLencanaList = [];

  Future<List<LencanaModel>> fetchDataLencana(GlobalKey key, AsyncSnapshot<DatabaseEvent> snapshot) async {
    Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;

    final jsonMap = jsonDecode(jsonEncode(data));
    final models = (jsonMap as Map<String, dynamic>?)
      ?.entries
      .map((entry) => LencanaModel.fromJson(entry.key, entry.value))
      .toList();
    listLencana = models ?? [];
    return models ?? [];
  }

  Future<void> getLencana(GlobalKey key, String id) async {
    try {
      await dbReference.child('users').child(auth.currentUser!.uid).child('id_lencana').push().set({
        'lencana':id
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
  }

  Future<List> userLencana(GlobalKey key) async {
    try {
      final snapshot = await dbReference.child("users").child(auth.currentUser!.uid).child('id_lencana').once();
      Map<dynamic, dynamic>? data = snapshot.snapshot.value as Map?;

      userLencanaList.clear();
      data?.forEach((key, value) {
        var fetch = value['lencana'];
        userLencanaList.add(fetch);
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return userLencanaList;
  }

  Future<String> fetchDataImage(GlobalKey key, String path) async {
    try{
      String file = await storage.ref().child('feature-requirement').child(path).getDownloadURL();
      filesImage = file;
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return filesImage;
  }
}