
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/list_quiz.dart';
import 'package:tp_flutter_jaugey_nohan/jeu.dart';
import 'package:tp_flutter_jaugey_nohan/select.dart';

import 'Model/Question.dart';

class EditQuestion extends StatelessWidget{
  var title;

  EditQuestion({Key? key, required this.title, required this.question}) : super(key: key);

  Question question;

  void sauvegarder(){

  }

  void commuter(bool? b){

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
                Row(
                  children: const <Widget>[
                    Text("Question"),
                    TextField()
                  ],
                ),
                Row(
                  children: [
                    Text("Véracité"),
                    Checkbox(value: false, onChanged: commuter)
                  ],
                )

              ]
          )
      ),
    );
  }
}