import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtyfy/view/detail_obesitas.dart';
import 'package:healtyfy/view/edukasi.view.dart';
import 'package:healtyfy/widget/artikel_dashboard.dart';
import 'package:healtyfy/widget/category.dart';
import 'package:healtyfy/widget/detail_edukasi_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Challange"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ]),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    height: 140, width: double.infinity, color: Colors.brown),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://studiolorier.com/wp-content/uploads/2018/10/Profile-Round-Sander-Lorier.jpg")),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          width: 2))),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Halo Naufal, Selamat Datang !",
                                style:
                                    GoogleFonts.montserrat(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Category(imagePath: "assets/recipe-book.png", title: "Resep"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EdukasiView()),
                      );
                    },
                    child: Category(
                        imagePath: "assets/book.png", title: "Edukasi"),
                  ),
                  Category(imagePath: "assets/bmi.png", title: "BMI"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Artikel",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetobView()),
                );
              },
              child: Artikel(
                imagePath: "assets/obesitas.png",
                deskripsi:
                    "Penyebab Obesitas dapat berakibat fatal bagi kesehatan",
              ),
            ),
            Artikel(
              imagePath: "assets/obesitas.png",
              deskripsi:
                  "Penyebab Obesitas dapat berakibat fatal bagi kesehatan",
            ),
            Artikel(
              imagePath: "assets/obesitas.png",
              deskripsi:
                  "Penyebab Obesitas dapat berakibat fatal bagi kesehatan",
            ),
          ],
        )),
      ),
    );
  }
}
