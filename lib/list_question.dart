

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/question.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';
import 'package:tp_flutter_jaugey_nohan/edit_question.dart';

class ListQuestion extends StatefulWidget {
  ListQuestion({Key? key, required this.title, required this.quiz})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  final String title;
  final Quiz quiz;
  String newText = "";

  @override
  State<ListQuestion> createState() => _SelectState();
}

class _SelectState extends State<ListQuestion> {

  void select(int i) async{
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  EditQuestion(title: "", question: widget.quiz.getQuestion(i)))
    );
    setState(() {
      Quiz.refresh();
    });
  }

  void delete(DismissDirection d, int question,int idQuestion) async{
    await Quiz.quizzDBHelper.supprimerQuestion(idQuestion);
    setState(() {
      widget.quiz.remove(question);
      Quiz.refresh();
    });
  }

  void ajouter(String s) async{
    Navigator.pop(context, 'OK');
    int id = await Quiz.quizzDBHelper.ajouterQuestion(widget.quiz.idQuizz, s);
    Question q = Question(s, [],id);
    Question.questionActuelle = widget.quiz.size();
    setState(() {
      widget.quiz.addQuestion(q);
      Quiz.refresh();
    });
    print(widget.quiz.questions);


    print("ajout de $s");
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  EditQuestion(title: "Edition de la nouvelle question", question: q))
    );

  }


  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: ReorderableListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: widget.quiz.questions.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = widget.quiz.getQuestion(index);
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
              key: Key(item.question),
              child: ListTile(
                title:  Text(item.question,
                    style:const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ).apply(
                      color: Colors.white,
                    )),
                  subtitle: Text("R??ponse : ${item.getBonneReponse().libelle}",
                      style:const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ).apply(
                        color: Theme.of(context).colorScheme.secondary,
                      )
                  ),
                onTap: () => { select(index) },
              ),
              onDismissed: (d) => {delete(d, index,item.idQuestion)},
          );
        }, onReorder: (int oldIndex, int newIndex) {
          changeOrdre(oldIndex,newIndex);
      },
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Entrez la nouvelle question",
                          ),
                          onChanged: (String s)=>{
                            widget.newText = s
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
                          ajouter(widget.newText)
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

  Future<void> _addQuestionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void changeOrdre(int oldIndex, int newIndex){
    int indexOld=oldIndex+1;
    int indexNew=newIndex;
    if(oldIndex>newIndex){
      indexNew+=1;
    }

    Quiz.quizzDBHelper.changeIndexQuestion(widget.quiz.idQuizz,indexOld, indexNew);
    Question q = widget.quiz.questions[indexOld-1];
    widget.quiz.questions.removeAt(indexOld-1);
    widget.quiz.questions.insert(indexNew-1, q);
    setState(() {
      Quiz.refresh();
    });

  }
}
