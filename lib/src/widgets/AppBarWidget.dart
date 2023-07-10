import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/ScreenSize.dart';
import '../utils/AppColors.dart';

class AppBarWidget extends StatefulHookConsumerWidget {
  List<String> tabItem;
  Function selectedCallback;

  AppBarWidget({
    super.key,
    required this.tabItem,
    required this.selectedCallback
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends ConsumerState<AppBarWidget> {
  var selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenHeight(context) * 0.17,
      width: double.maxFinite,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Color(AppColors.bgPrimarySoft)
      ),
      child: SafeArea(
        child: Center(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedCallback(index);
                    selectedTab = index;
                  });
                },
                child: Center(
                  child: Container(
                    width: 85,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(selectedTab == index ? AppColors.bgWhite : AppColors.bgPrimary),
                      borderRadius: const BorderRadius.all(Radius.circular(13))
                    ),
                    child: Center(
                      child: Text(
                        widget.tabItem[index],
                        style: GoogleFonts.poppins(
                          color: Color(selectedTab == index ? AppColors.bgPrimary : AppColors.bgWhite)
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: ScreenSize.screenWidth(context) * 0.02,);
            },
            shrinkWrap: true,
            itemCount: widget.tabItem.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}