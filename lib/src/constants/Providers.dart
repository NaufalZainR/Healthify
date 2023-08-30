import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healtyfy/src/repository/AuthRepository.dart';
import 'package:healtyfy/src/repository/EdukasiRepository.dart';
import 'package:healtyfy/src/repository/LencanaRepository.dart';
import 'package:healtyfy/src/repository/TugasRepository.dart';

final authCheckerProvider = StreamProvider((ref) {
  return ref.watch(authRepositoryProvider).authStateChange;
},);

final tugasRepositoryProvider = Provider((ref) {
  return TugasRepository();
},);

final lencanaRepositoryProvider = Provider((ref) {
  return LencanaRepository();
},);

final authRepositoryProvider = Provider((ref) {
  return AuthRepository();
},);

final edukasiRepositoryProvider = Provider((ref) {
  return EdukasiRepository();
},);