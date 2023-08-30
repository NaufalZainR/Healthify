import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healtyfy/src/feature/tantangan/model/CatatanModel.dart';
import 'package:healtyfy/src/feature/tantangan/model/MinumModel.dart';
import 'package:healtyfy/src/feature/tantangan/model/RankModel.dart';
import 'package:healtyfy/src/feature/tantangan/model/TugasModel.dart';
import 'package:healtyfy/src/utils/Snackbar.dart';
import 'package:intl/intl.dart';

class TugasRepository{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<TugasModel> listTugas = [];
  String filesImage = '';
  List userTugasList = [];
  List userTugasListLencana = [];
  List<RankModel> listRank = [];
  List<RankModel> listRankFilter = [];
  List<CatatanModel> listCatatan = [];
  List<MinumModel> listMinum = [];

  Future<List<TugasModel>> fetchDataTugas(GlobalKey key, AsyncSnapshot<DatabaseEvent> snapshot) async {
    Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;

    listTugas.clear();
    try{
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
    try{
      String file = await storage.ref().child('feature-requirement').child(path).getDownloadURL();
      filesImage = file;
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return filesImage;
  }

  Future<List> userTugas(GlobalKey key) async {
    try{
      final snapshot = await dbReference.child("users").child(auth.currentUser!.uid).child('id_tugas').once();
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

  Future<List> userTugasLencana(GlobalKey key) async {
    try{
      final snapshot = await dbReference.child("users").child(auth.currentUser!.uid).child('id_tugas_lencana').once();
      Map<dynamic, dynamic>? data = snapshot.snapshot.value as Map?;

      userTugasListLencana.clear();
      data?.forEach((key, value) {
        var fetch = value['lencana'];
        userTugasListLencana.add(fetch);
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
    return userTugasListLencana;
  }

  Future<void> tugasSelesai(GlobalKey key, String idTugas, int score) async {
    try{
      await dbReference.child("users").child(auth.currentUser!.uid).child('id_tugas').push().set({
        'lencana': idTugas
      });

      await dbReference.child('users').child(auth.currentUser!.uid).update({
        'score':ServerValue.increment(score)
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
  }

  Future<void> tugasLencanaSelesai(GlobalKey key, String idTugas, int score) async {
    try{
      await dbReference.child("users").child(auth.currentUser!.uid).child('id_tugas_lencana').push().set({
        'lencana': idTugas
      });

      await dbReference.child('users').child(auth.currentUser!.uid).update({
        'score':ServerValue.increment(score)
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    }
  }

  Future<void> fetchUserRank(GlobalKey key, AsyncSnapshot<DatabaseEvent> snapshot) async {
    try {
      Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;

      final jsonMap = jsonDecode(jsonEncode(data));
      final models = (jsonMap as Map<String, dynamic>?)
        ?.entries
        .map((entry) => RankModel.fromJson(entry.key, entry.value))
        .toList();

      listRank = models ?? [];
      listRank.sort((a, b) => b.score.compareTo(a.score),);

      listRankFilter = listRank.toList();
      listRankFilter.sort((a, b) => b.score.compareTo(a.score),);
      listRankFilter.removeRange(0, 3);
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> saveCatatan(GlobalKey key, String catatan) async {
    try {
      dbReference.child('catatan').child(auth.currentUser!.uid).push().set({
        'catatan':catatan
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> fetchCatatan(GlobalKey key, AsyncSnapshot<DatabaseEvent> snapshot) async {
    listCatatan.clear();
    try {
      Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;

      data?.forEach((key, value) {
        var fetch = CatatanModel(
          id: key,
          catatan: value['catatan']
        );
        listCatatan.add(fetch);
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> deleteCatatan(BuildContext context, String id) async {
    try {
      dbReference.child('catatan').child(auth.currentUser!.uid).child(id).remove();
      Snackbar.snackbarShow(context, 'Berhasil dihapus');
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(context, '$e');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> tambahMinum(BuildContext context, int value) async {
    try {
      await dbReference.child('users').child(auth.currentUser!.uid).child('minum').push().set({
        'minumMl':value,
        'time':DateFormat('dd-MM-yyyy').format(DateTime.now())
      });

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: Text(
              'Berhasil menambahkan minum!'
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
      await showDialog(
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
  }

  Future<void> fetchMinum(BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) async {
    listMinum.clear();
    try {
      Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;

      data?.forEach((key, value) {
        var fetch = MinumModel(
          id: key,
          minumMl: value['minumMl'],
          time: value['time']
        );
        listMinum.add(fetch);
      });
      listMinum.sort((a, b) => b.time!.compareTo(a.time!),);
    } on FirebaseAuthException catch (e) {
      await showDialog(
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
  }

  Future<void> hapusMinum(BuildContext context, String id) async {
    try {
      await dbReference.child('users').child(auth.currentUser!.uid).child('minum').child(id).remove();

      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: Text(
              'Berhasil menghapus minum!'
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
      await showDialog(
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
  }
}