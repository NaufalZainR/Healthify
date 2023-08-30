import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/constants/Providers.dart';
import 'package:healtyfy/src/feature/saya/view/SayaUbahProfileView.dart';
import 'package:healtyfy/src/feature/saya/view/widgets/CustomButtonWidget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../constants/ScreenSize.dart';
import '../../../utils/AppColors.dart';
import '../../../widgets/AppBarWidget.dart';
import '../../kalkulator/view/bmi/HitungBMIRiwayat.dart';

class SayaView extends StatefulHookConsumerWidget {
  const SayaView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SayaViewState();
}
class _SayaViewState extends ConsumerState<SayaView> {
  GlobalKey sayaKey = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: ScreenSize.screenHeight(context) * 0.17,
            width: ScreenSize.screenWidth(context),
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color(AppColors.bgPrimarySoft)
            ),
            child: SafeArea(
              child: Center(
                child: Text(
                  'Saya',
                  style: GoogleFonts.poppins(
                    color: const Color(AppColors.bgWhite),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                )
              ),
            ),
          ),
          const SizedBox(height: 46,),
          Expanded(
            child: StreamBuilder(
              stream: dbReference.child('users').child(auth.currentUser!.uid).onValue,
              builder: (context, snapshot) {
                Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: ref.read(authRepositoryProvider).fetchUserImage(sayaKey, data?['photo'] ?? ''),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const SizedBox(
                                width: 50,
                                height: 50,
                                child: Center(child: CircularProgressIndicator())
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.none) {
                            return Icon(MdiIcons.account, size: 130,);
                          }
                          return SizedBox(
                            width: ScreenSize.screenWidth(context),
                            child: snapshot.data! != ''
                            ? SizedBox(
                              width: 130,
                              height: 130,
                              child: CircleAvatar(backgroundImage: Image.network(snapshot.data!).image))
                            : Icon(MdiIcons.account, size: 130,),) ;
                        },
                      ),
                      const SizedBox(height: 7,),
                      Text(
                        data?['username'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        auth.currentUser!.email.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(height: 43,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SayaUbahProfileView()
                                )
                              );
                            },
                            child: Container(
                              width: 135,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                  color: Color(AppColors.bgPrimary),
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                              ),
                              child: Text(
                                'Ubah Profile',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 22,),
                          GestureDetector(
                            onTap: () {
                              ref.read(authRepositoryProvider).signOut(sayaKey);
                            },
                            child: Container(
                              width: 135,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                  color: Color(AppColors.bgPrimary),
                                  borderRadius: BorderRadius.all(Radius.circular(6))
                              ),
                              child: Text(
                                'Logout',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30,),
                      StreamBuilder(
                        stream: dbReference.child('kalkulator_result').child(auth.currentUser!.uid).limitToLast(1).onValue,
                        builder: (context, snapshot) {
                          Map<dynamic, dynamic>? data = snapshot.data?.snapshot.value as Map?;
                          return CustomButtonWidget(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HitungBMIRiwayat()
                                )
                              );
                            },
                            teks: 'BMI Kamu',
                            result: '${data?.values.first['result']}'
                          );
                        }
                      ),
                      const SizedBox(height: 8,),
                      CustomButtonWidget(
                        onTap: (){

                        },
                        teks: 'Kalori Kamu',
                        result: '22.0'
                      ),
                      const SizedBox(height: 8,),
                      CustomButtonWidget(
                        onTap: (){

                        },
                        teks: 'Catatan Kamu',
                        result: '22.0'
                      ),
                      const SizedBox(height: 8,),
                      CustomButtonWidget(
                        onTap: (){

                        },
                        teks: 'Minum Kamu',
                        result: '22.0'
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}