
import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/list_quiz.dart';
import 'package:tp_flutter_jaugey_nohan/select.dart';

class Accueil extends StatelessWidget{
  var title;

  Accueil({Key? key, required this.title}) : super(key: key);

  void jouer(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  Select(title: title)),
    );
  }

  void telecharger(BuildContext context){

  }

  void modifierQuestions(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ListQuiz(title: ""))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              ElevatedButton(onPressed: () => {jouer(context)}, child: Text("Jouer")),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(onPressed: () => {modifierQuestions(context)}, child: Text("Modifier les Quizzes")),
                    ElevatedButton(onPressed: () => {telecharger(context)}, child: Text("Télécharger"))
                  ]
              )
            ]
        )
      ),
    );
  }
}