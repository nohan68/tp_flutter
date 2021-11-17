
import 'package:flutter/material.dart';

import 'Model/Question.dart';
import 'Model/Reponse.dart';

class EditQuestion extends StatelessWidget{
  var title;

  EditQuestion({Key? key, required this.title, required this.question}) : super(key: key);

  Question question;

  void sauvegarder(){

  }

  void commuter(Reponse r, bool ?b){

    r.setVeracite(b);
  }

  List<Widget> getWidgets(){
    List<Widget> wg = [];
    wg.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "${question.question}",
            )
        )
      )
    );
    for(Reponse r in question.reponses){
      wg.add(
        CheckboxListTile(value: r.veracite, onChanged: (bool ?b) => {commuter(r, b) }, title: Text(r.libelle),)
      );
    }
    return wg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: getWidgets()
      )
    );
  }
}