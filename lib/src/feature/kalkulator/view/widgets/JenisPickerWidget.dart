import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/src/utils/AppColors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class JenisPickerWidget extends ConsumerStatefulWidget {
  Function onTap;

  JenisPickerWidget({super.key, required this.onTap});

  @override
  ConsumerState createState() => _JenisPickerWidgetState();
}

class _JenisPickerWidgetState extends ConsumerState<JenisPickerWidget> {
  List<String> jenisKelamin = ['Laki laki', 'Perempuan'];

  List<String> imageAssets = [
    'assets/images/male.png',
    'assets/images/female.png'
  ];

  var jenisKelaminIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(60),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 24, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.onTap(index);
              jenisKelaminIndex = index;
            });
          },
          child: Container(
            width: 107,
            decoration: BoxDecoration(
                color: index == jenisKelaminIndex
                    ? const Color(AppColors.bgSoftGrey)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 17, color: Colors.black.withOpacity(0.25))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageAssets[index],
                  width: 57,
                  height: 57,
                ),
                Text(
                  jenisKelamin[index],
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        );
      },
      itemCount: 2,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }
}
