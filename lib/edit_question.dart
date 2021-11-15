import 'package:flutter/material.dart';

import 'Model/question.dart';

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