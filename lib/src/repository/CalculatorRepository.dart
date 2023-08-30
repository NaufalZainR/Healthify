import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtyfy/src/feature/kalkulator/model/BMIModel.dart';
import 'package:healtyfy/src/utils/Snackbar.dart';

class CalculatorRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  List<BMIModel> listSaveBMI = [];

  Future<void> saveBMI(
      GlobalKey key, double result, int jenisKelaminIndex) async {
    try {
      var keterangan = '';
      if (jenisKelaminIndex == 0) {
        if (result < 18.5) keterangan = 'Kurus';
        if (result >= 18.5 && result < 24.9) keterangan = 'Normal';
        if (result >= 25 && result < 29.9) keterangan = 'Kelebihan Berat Badan';
        if (result >= 30) keterangan = 'Obesitas';
      } else {
        if (result < 18.5) keterangan = 'Kurus';
        if (result >= 18.5 && result < 23.9) keterangan = 'Normal';
        if (result >= 24 && result < 29.9) keterangan = 'Kelebihan Berat Badan';
        if (result >= 30) keterangan = 'Obesitas';
      }

      await dbReference
          .child('kalkulator_result')
          .child(auth.currentUser!.uid)
          .push()
          .set({'result': result, 'keterangan': keterangan});

      Snackbar.snackbarShow(key.currentContext!, 'Berhasil dihitung!');
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> fetchSaveBMI(
      GlobalKey key, AsyncSnapshot<DatabaseEvent> snapshot) async {
    try {
      Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;
      listSaveBMI.clear();
      data?.forEach((key, value) {
        var fetch = BMIModel(
            id: key,
            result: value['result'].toDouble(),
            keterangan: value['keterangan']);
        listSaveBMI.add(fetch);
      });
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> deleteBMI(GlobalKey key, String id) async {
    try {
      dbReference
          .child('kalkulator_result')
          .child(auth.currentUser!.uid)
          .child(id)
          .remove();

      Snackbar.snackbarShow(key.currentContext!, 'Berhasil dihapus!');
    } on FirebaseAuthException catch (e) {
      Snackbar.snackbarShow(key.currentContext!, '$e');
    } catch (e) {
      debugPrint('$e');
    }
  }
}
