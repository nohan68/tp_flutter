
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
      backgroundColor: Theme.of(context).backgroundColor,

      body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 50),
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ).apply(
                    color: Colors.white,
                  ),


                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    hintText: widget.question.question,
                  ),
                  initialValue: widget.question.question,
                  onChanged: (String s) => {widget.newTextQuestion = s},
                  onFieldSubmitted: (String s)=>{
                    editQuestion(s)
                  },
                )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child:
              ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: widget.question.reponses.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final Reponse item = widget.question.reponses[index];
                  return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Icon(Icons.delete,
                            color: Colors.white,

                          ),


                        ),
                      ),
                      key: Key(item.libelle),
                      child: RadioListTile(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        title: Text(item.libelle,
                            style:const TextStyle(
                              fontSize: 20,
                            ).apply(
                              color: Colors.white,
                            )),
                        onChanged: (value) {
                          changeVeracite(index);
                        },
                        groupValue: indexBonneRep,
                        value: item.index,
                      ),
                      onDismissed: (d) => {
                        dissmiss(d,item, index)
                      }
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: valider, child: const Text("Valider"),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  textStyle:const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold)
              ),),
          ]
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

  dissmiss(direction, item, index) {
    if(direction == DismissDirection.startToEnd){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Modifier la réponse'),
          actions: <Widget>[
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: item.libelle,
                      ),
                      initialValue: item.libelle,
                      onChanged: (String s)=>{
                        widget.newTextReponse = s
                      },
                    )
                ),
                Row(
                  children: [
                    //RadioListTile( groupValue: indexBonneRep,  value:index, onChanged: (int ?i) => { }, title: Text(item.libelle),),
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
                      child: const Text('Modifier'),
                    ),
                  ],
                )
              ],
            )

          ],
        ),
      );
      setState(() {

      });
    }
    if(direction == DismissDirection.endToStart){
      setState(() {
        Reponse.deleteReponse(widget.question.idQuestion, index);
        // TODO: effacer
        widget.question.reponses.removeAt(index);
      });
    }

  }

  void changeVeracite(int index) {
    Quiz.quizzDBHelper.changeReponseQuestion(widget.question.reponses[index]);
    setState(() {
      Quiz.refresh();
      indexBonneRep = index+1;
    });
  }
}