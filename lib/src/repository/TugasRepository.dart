import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtyfy/src/feature/tantangan/model/TugasModel.dart';
import 'package:healtyfy/src/utils/Snackbar.dart';

class TugasRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<TugasModel> listTugas = [];
  String filesImage = '';

  Future<List<TugasModel>> fetchDataTugas(
      GlobalKey key, AsyncSnapshot<DatabaseEvent> snapshot) async {
    Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;

    listTugas.clear();
    try {
      data?.forEach((key, value) {
        var fetch = TugasModel(
          id: key,
          deskripsi: value['deskripsi'],
          score: value['score'],
          titleText: value['title_text'],
          photoPath: value['photo_path'],
        );
        listTugas.add(fetch);
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return listTugas;
  }

  Future<String> fetchDataImage(GlobalKey key, String path) async {
    try {
      filesImage = await storage
          .ref()
          .child('feature-requirement')
          .child(path)
          .getDownloadURL();
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return filesImage;
  }
}
