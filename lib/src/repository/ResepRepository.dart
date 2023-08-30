import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtyfy/src/feature/resep/model/ResepModel.dart';

import '../utils/Snackbar.dart';

class ResepRepository{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<ResepModel> listResep = [];

  Future<List<ResepModel>> fetchListResep (GlobalKey key, AsyncSnapshot<DatabaseEvent> snapshot) async {
    Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;

    try {
      final jsonMap = jsonDecode(jsonEncode(data));
      final models = (jsonMap as Map<String, dynamic>?)
        ?.entries
        .map((e) => ResepModel.fromJson(e.key, e.value))
        .toList();

      listResep = models ?? [];
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return listResep;
  }
}