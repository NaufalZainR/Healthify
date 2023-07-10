import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../constants/ScreenSize.dart';
import '../../../../utils/AppColors.dart';

class TinggiPickerWidget extends ConsumerStatefulWidget {
  Function onChanged;

  TinggiPickerWidget({
    super.key,
    required this.onChanged
  });

  @override
  ConsumerState createState() => _TinggiPickerWidgetState();
}

class _TinggiPickerWidgetState extends ConsumerState<TinggiPickerWidget> {
  var sliderValue = 170.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      width: ScreenSize.screenWidth(context),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              blurRadius: 17,
              color: Colors.black.withOpacity(0.25)
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            'Tinggi',
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(AppColors.bgGrey)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    sliderValue--;
                    widget.onChanged(sliderValue);
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(AppColors.bgPrimary)
                  ),
                  child: Icon(MdiIcons.minus, color: Colors.white,),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: '${sliderValue.toInt()}',
                          style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          )
                      ),
                      const WidgetSpan(
                          child: SizedBox(width: 11,)
                      ),
                      TextSpan(
                          text: 'cm',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(AppColors.greyColor)
                          )
                      ),
                    ]
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    sliderValue++;
                    widget.onChanged(sliderValue);
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Color(AppColors.bgPrimary)
                  ),
                  child: Icon(MdiIcons.plus, color: Colors.white,),
                ),
              ),
            ],
          ),
          Slider(
            value: sliderValue,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
                widget.onChanged(sliderValue);
              });
            },
            min: 100,
            max: 300,
          )
        ],
      ),
    );
  }
}
