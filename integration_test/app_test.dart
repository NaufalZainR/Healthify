import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healtyfy/main.dart';
import 'package:healtyfy/src/feature/auth/view/login.dart';
import 'package:healtyfy/src/healtyfy.dart';

void main() async {
  Widget createWidgetTest() {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Test',
        home: Healtyfy(),
      ),
    );
  }

  setUp(() async {
    await Firebase.initializeApp();
  },);

  tearDown(() async {
    await FirebaseAuth.instance.signOut();
  },);

  testWidgets('Login test', (tester) async {
    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('email')), 'mody@mail.com');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('password')), '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Masuk').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('Register test', (tester) async {
    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Daftar').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('username')), 'hahatesting');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('email')), 'testinghaha@mail.com');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('password')), '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Daftar').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('Forgot pass test', (tester) async {
    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lupa Kata Sandi?').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('email')), 'testinghaha@mail.com');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kirim').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('tantangan - peringkat dan profil tab', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Peringkat').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profil').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('tantangan - tugas', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tugas').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Bangun pagi hari').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Selesai').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('tantangan - lencana', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lencana').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Olahraga').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Olahraga dong bro').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Selesai').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Selesai').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ambil Lencana').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('tantangan - minum', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tugas').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Minum').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('200').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Oke').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Minum').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Riwayat').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('delete')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Oke').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Selesai').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('tantangan - catatan', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tugas').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Catatan').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('tambah')).last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('field')), 'testing saja');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tambah').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('delete')).last);
    await tester.pumpAndSettle();
  },);

  testWidgets('edukasi - tab dan list testing', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Edukasi').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Berita').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Artikel').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Video').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('All').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Olahraga 10 Menit Bakar Kalori').last);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  },);

  testWidgets('resep - tab dan list testing', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Resep').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sarapan').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Makan Siang').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Makan Malam').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('All').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('omelete').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('kalkulator - hitung bmi', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kalkulator').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Perempuan').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('tinggiMin')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('tinggiMin')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('umurPlus')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('beratPlus')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('beratPlus')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Hitung').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Edukasi').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('kalkulator - hitung kalori', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kalkulator').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Hitung Kalori Harian').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('tinggiPlus')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('tinggiPlus')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('umurMin')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('beratMin')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('beratMin')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Hitung').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Resep').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('saya - ubah photo', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Saya').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ubah Profile').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('changePhoto')));
    await tester.pumpAndSettle();
  },);

  testWidgets('saya - ubah username', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Saya').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ubah Profile').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('username')).last, 'Naufal');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ubah').last);
    await tester.pumpAndSettle();
  },);

  testWidgets('saya - log out', (tester) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'mody@mail.com',
      password: '123456'
    );

    await tester.pumpWidget(createWidgetTest());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Saya').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Logout').last);
    await tester.pumpAndSettle();
  },);
}