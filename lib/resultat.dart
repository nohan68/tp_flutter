import 'package:flutter/material.dart';

class Resultat extends StatelessWidget {
  int bonneReponses, mauvaisesReponses;

   Resultat( this.bonneReponses, this.mauvaisesReponses);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
        alignment: Alignment.center,
        child:
        Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("$bonneReponses bonnes réponses",style:const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ).apply(
                    color: Colors.white,
                  )),
                  Text("$mauvaisesReponses mauvaises réponses",style:const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ).apply(
                    color: Colors.white,
                  ))
                ],
              )
            )
        )
        )
    );
  }
}