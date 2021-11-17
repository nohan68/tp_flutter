
import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';

import 'Model/question.dart';
import 'Model/reponse.dart';


class EditQuestion extends StatefulWidget{
  var title;

  EditQuestion({Key? key, required this.title, required this.question})
      : super(key: key);

  Question question;

  @override
  State<EditQuestion> createState() => EditQuestionState();

}

class EditQuestionState extends State<EditQuestion>{

  int indexBonneRep = 0;

  void sauvegarder(){

  }



  void commuter(int ?i){
    Quiz.quizzDBHelper.changeReponseQuestion(widget.question.reponses.firstWhere((element) => element.index==i));
    Quiz.init();
    if(i!=null) {
      setState(() {
        indexBonneRep = i;
      });
    }
  }

  void editQuestion(String s){
    Quiz.quizzDBHelper.changeQuestion(widget.question.idQuestion,s );
    Quiz.init();
    widget.question.question=s;
  }

  List<Widget> getWidgets(){
    List<Widget> wg = [];
    wg.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.question.question,
            ),
          onSubmitted: (String s)=>{
              editQuestion(s)
          },
        )
      )
    );
    print(indexBonneRep);
    for(Reponse r in widget.question.reponses){
      print("i:${r.index}");
      wg.add(
        RadioListTile( groupValue: indexBonneRep,  value:r.index, onChanged: (int ?i) => {commuter(i) }, title: Text(r.libelle),)
      );
    }
    return wg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: getWidgets()
      )
    );
  }

  @override
  void initState() {
    indexBonneRep=widget.question.reponses.firstWhere((element) => element.veracite).index;
  }
}