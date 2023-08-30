import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:intl/intl.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class MinumLacakView extends ConsumerStatefulWidget {
  const MinumLacakView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MinumLacakViewState();
}

class _MinumLacakViewState extends ConsumerState<MinumLacakView> {
  GlobalKey minumLacakKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  int totalMinum = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarBackWidget(),
        const SizedBox(height: 46,),
        Expanded(
          child: Column(
            children: [
              Text(
                'Pelacakan Minum',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 50,),
              StreamBuilder(
                stream: dbReference.child('users').child(auth.currentUser!.uid).child('minum').onValue,
                builder: (context, snapshot) {
                  Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;
                  data?.forEach((key, value) {
                    if (DateFormat('dd-MM-yyyy').format(DateTime.now()) == value['time']) {
                      totalMinum = totalMinum + value['minumMl'] as int;
                    }
                  },);
                  return PrettyGauge(
                    gaugeSize: 300,
                    minValue: 0,
                    maxValue: 2500,
                    segments: [
                      GaugeSegment('', 2500, const Color(0xffa3bcff)),
                    ],
                    valueWidget: Text(
                      '$totalMinum',
                      style: const TextStyle(fontSize: 40),
                    ),
                    currentValue: totalMinum.toDouble(),
                    needleColor: Colors.blue,
                  );
                }
              ),
            ],
          ),
        )
      ],
    );
  }
}