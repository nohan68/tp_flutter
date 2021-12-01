import 'package:flutter/material.dart';

class Resultat extends StatelessWidget {
  int bonneReponses, mauvaisesReponses;

   Resultat( this.bonneReponses, this.mauvaisesReponses);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("${this.bonneReponses} bonnes réponses"),
            Text("${this.mauvaisesReponses} mauvaises réponses")
          ],
        )
      )
    );
  }
}