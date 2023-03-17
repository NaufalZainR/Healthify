import 'package:flutter/material.dart';
import 'package:healtyfy/view/utils/constant.dart';

class DetobView extends StatelessWidget {
  const DetobView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                )),
            Text("Artikel")
          ],
        ),
        Text(
          "Obesitas",
          style: textTextStyle.copyWith(fontSize: 21, fontWeight: bold),
        ),
        Container(
          margin: EdgeInsets.all(20),
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Image.asset('assets/obesitas.png'),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text("Obesitas adalah kondisi yang menggambarkan seseorang memiliki badan berlebih, kegemukan dan mengandung banyak lemak pada tubuhnya. Terdapat bermacam cara untuk melakukan klasifikasi terhadap kegemukan, tetapi metode yang paling banyak digunakan adalah menggunakan indeks massa tubuh (IMT). Metode ini dilakukan dengan mengukur perbandingan antara berat badan (kilogram) dan tinggi badan (meter) kuadrat.Bukan sekadar masalah citra tubuh, obesitas  adalah masalah medis yang meningkatkan risiko berbagai penyakit seperti jantung, diabetes, tekanan darah tinggi, dan kanker. Ada banyak alasan mengapa banyak orang yang kesulitan menurunkan berat badan. Sebab, obesitas umumnya hasil dari faktor keturunan, fisiologis dan lingkungan.Kabar baiknya, penurunan berat badan sekecil apapun mampu memperbaiki atau mencegah masalah kesehatan yang berhubungan dengan obesitas. Diet sehat, peningkatan aktivitas fisik, dan perubahan perilaku dapat membantu seseorang menurunkan berat badan."),
        ),
      ]),
    );
  }
}
