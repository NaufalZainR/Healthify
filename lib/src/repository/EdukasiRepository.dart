import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtyfy/src/feature/edukasi/model/EdukasiModel.dart';

import '../utils/Snackbar.dart';

class EdukasiRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<EdukasiModel> listEdukasi = [];

  Future<List<EdukasiModel>> fetchListEdukasi(
      GlobalKey key, AsyncSnapshot<DatabaseEvent> snapshot) async {
    Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;

    try {
      final jsonMap = jsonDecode(jsonEncode(data));
      final models = (jsonMap as Map<String, dynamic>?)
          ?.entries
          .map((e) => EdukasiModel.fromJson(e.key, e.value))
          .toList();

      listEdukasi = models ?? [];
      return models ?? [];
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return [];
  }
}
