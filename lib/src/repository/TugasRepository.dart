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
  List userTugasList = [];

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
      String file = await storage
          .ref()
          .child('feature-requirement')
          .child(path)
          .getDownloadURL();
      filesImage = file;
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return filesImage;
  }

  Future<List> userTugas(GlobalKey key) async {
    try {
      final snapshot = await dbReference
          .child("users")
          .child(auth.currentUser!.uid)
          .child('id_tugas')
          .once();
      Map<dynamic, dynamic>? data = snapshot.snapshot.value as Map?;

      userTugasList.clear();
      data?.forEach((key, value) {
        var fetch = value['lencana'];
        userTugasList.add(fetch);
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return userTugasList;
  }

  Future<void> tugasSelesai(GlobalKey key, String idTugas, int score) async {
    try {
      await dbReference
          .child("users")
          .child(auth.currentUser!.uid)
          .child('id_tugas')
          .push()
          .set({'lencana': idTugas});

      await dbReference
          .child('users')
          .child(auth.currentUser!.uid)
          .update({'score': ServerValue.increment(score)});
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
  }
}
