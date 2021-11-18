
import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';

import 'Model/question.dart';
import 'Model/reponse.dart';


class EditQuestion extends StatefulWidget{
  var title;

  EditQuestion({Key? key, required this.title, required this.question})
      : super(key: key);

  Question question;
  String newTextReponse = "";
  String newTextQuestion = "";

  @override
  State<EditQuestion> createState() => EditQuestionState();

}

class EditQuestionState extends State<EditQuestion>{

  int indexBonneRep = 0;

  void sauvegarder(){

  }



  void commuter(int ?i) async{
    await Quiz.quizzDBHelper.changeReponseQuestion(widget.question.reponses.firstWhere((element) => element.index==i));
    Quiz.refresh();
    if(i!=null) {
      setState(() {
        indexBonneRep = i;
      });
    }
  }

  void editQuestion(String s) async{
    await Quiz.quizzDBHelper.changeQuestion(widget.question.idQuestion,s );
    Quiz.refresh();
    widget.question.question=s;
  }

  void ajouter(String s)async {
    await Quiz.quizzDBHelper.ajouterReponseQuestion(widget.question.idQuestion, s);
    Reponse r = Reponse(
        s,
        false,
        widget.question.getReponseSize()+1,
        widget.question.idQuestion
    );
    Quiz.refresh();
    setState(() {
      widget.question.ajouterReponse(r);
    });
    Navigator.pop(context, 'OK');
  }

  void valider(){
    setState(() {
      editQuestion(widget.newTextQuestion);
    });
    Navigator.of(context).pop();


  }

  List<Widget> getWidgets(){
    List<Widget> wg = [];
    wg.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: widget.question.question,
            ),
          initialValue: widget.question.question,
          onChanged: (String s) => {widget.newTextQuestion = s},
          onFieldSubmitted: (String s)=>{
              editQuestion(s)
          },
        )
      )
    );
    for(Reponse r in widget.question.reponses){
      wg.add(
        RadioListTile( groupValue: indexBonneRep,  value:r.index, onChanged: (int ?i) => {commuter(i) }, title: Text(r.libelle),)
      );
    }
    wg.add(
      ElevatedButton(onPressed: valider, child: const Text("Valider"))
    );
    return wg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: getWidgets(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Nouvelle question'),
            actions: <Widget>[
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Entrez la nouvelle réponse",
                        ),
                        onChanged: (String s)=>{
                          widget.newTextReponse = s
                        },
                      )
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context, 'Cancel')
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => {
                          ajouter(widget.newTextReponse)
                        },
                        child: const Text('Ajouter'),
                      ),
                    ],
                  )
                ],
              )

            ],
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.newTextQuestion=widget.question.question;
    if(widget.question.reponses.isNotEmpty){
      indexBonneRep=(widget.question.reponses.firstWhere((element) => element.veracite, orElse: ()=> widget.question.reponses[0])).index;
    }else{
      indexBonneRep=1;
    }
  }
}