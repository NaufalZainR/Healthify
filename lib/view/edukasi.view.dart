import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/view/detail_edukasi.dart';

class EdukasiView extends StatelessWidget {
  const EdukasiView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.3,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/mangkoksehat.png"))),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                              // Within the SecondRoute widget
                              child: Icon(Icons.arrow_back),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailEdukasi()),
                    );
                  },
                  child: edukasiView(
                    imagePath: "assets/eggmayo.png",
                    title: "Edukasi",
                    detail: "testing 123",
                  ),
                ),
                edukasiView(
                  imagePath: "assets/eggmayo.png",
                  title: "Video",
                  detail: "testing 123",
                ),
                edukasiView(
                  imagePath: "assets/eggmayo.png",
                  title: "Edukasi",
                  detail: "testing 123",
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

class edukasiView extends StatelessWidget {
  final String imagePath;
  final String title;
  final String detail;
  const edukasiView({
    required this.imagePath,
    required this.title,
    required this.detail,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 240,
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17)),
              elevation: 8,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              child: SizedBox(
                height: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                      detail,
                      style: GoogleFonts.montserrat(fontSize: 13),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
