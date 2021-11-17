import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/Quiz.dart';
import 'package:tp_flutter_jaugey_nohan/resultat.dart';

import 'Model/Question.dart';
import 'Model/Reponse.dart';

class Jeu extends StatefulWidget {
  Jeu({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  final String title;

  @override
  State<Jeu> createState() => _JeuState();
}

class _JeuState extends State<Jeu> {
  int bonneReponses = 0;
  int mauvaisesReponses = 0;

  void suivant() {
    if(Question.questionActuelle < Quiz.getActuel().questions.length-1){
      setState(() {
        Question.questionActuelle++;
      });
    }else {
      finish();
    }
  }

  void finish(){
    Question.questionActuelle = 0;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  Resultat(this.bonneReponses, this.mauvaisesReponses)),
    );
  }

  void answer(Reponse r){

    if(r.veracite){
      bonneReponses++;
    }else{
      mauvaisesReponses++;
    }


    suivant();
  }

  List<Widget> getReponsesButton(){
    List<ElevatedButton> btns = [];
    for(Reponse r in Question.getActuelle().reponses){
      btns.add( ElevatedButton(onPressed: () => { answer(r) }, child: Text(r.libelle)));
    }
    return btns;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text( Question.getActuelle().question),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getReponsesButton(),
                ),
                ElevatedButton(
                  onPressed: suivant,
                  child: const Text('Suivant'),
                ),
              ],
            )
        )
    );
  }
}
