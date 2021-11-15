import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/Question.dart';
import 'package:tp_flutter_jaugey_nohan/Model/Quiz.dart';
import 'package:tp_flutter_jaugey_nohan/Model/Reponse.dart';
import 'package:tp_flutter_jaugey_nohan/accueil.dart';
import 'package:tp_flutter_jaugey_nohan/jeu.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Question q1 = new Question("Le Master en Informatique peut-il se faire en alternance ?");
    q1.reponses.add(new Reponse("Oui", true));
    q1.reponses.add(new Reponse("Non", false));
    
    Question q2 = new Question("Qui est le responsable du CMI ?");
    q2.reponses.add(new Reponse("B. Tatibouët", true));
    q2.reponses.add(new Reponse("A. Giorgetti", true));
    q2.reponses.add(new Reponse("F. Dadeau", true));

    Quiz quiz = Quiz();
    quiz.questions.add(q1);
    quiz.questions.add(q2);
    Quiz.quizzes.add(quiz);



    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Accueil(title: 'Quiz JAUGEY Nohan'),
    );
  }
}