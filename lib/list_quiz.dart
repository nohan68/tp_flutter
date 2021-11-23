

import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';
import 'package:tp_flutter_jaugey_nohan/list_question.dart';

class ListQuiz extends StatefulWidget {
  ListQuiz({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  final String title;
  String nouveauTitre = "";

  @override
  State<ListQuiz> createState() => _SelectState();
}

class _SelectState extends State<ListQuiz> {

  void select(int i){
    Quiz.quizActuel = i;
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ListQuestion(title: "", quiz: Quiz.get(i))),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: Quiz.quizzes.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = Quiz.get(index);
          return Dismissible(
              key: Key(item.nomQuizz),
              child: ListTile(
                  title: Text(item.nomQuizz),
                  subtitle: Text("$index"),
                  onTap: () => { select(index) }
              ),
              onDismissed: (d) => {delete(d, index)}
          );
          /*
            ListTile(
            title: Text("${item.nomQuizz}"),
            subtitle: Text("${item.questions.length}"),
            onTap: () => { select(index) },
          );

           */
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Nouveau quiz'),
        actions: <Widget>[
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nom du quiz",
                    ),
                    onChanged: (String s)=>{
                      widget.nouveauTitre = s
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
                      ajouter(widget.nouveauTitre)
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

  ajouter(String nouveauTitre)async {
    int? res = await Quiz.quizzDBHelper.ajouterQuizz(nouveauTitre);
    Quiz nouveauQuiz = Quiz(res!, nouveauTitre);

    setState(() {
      Quiz.add(nouveauQuiz);
      Quiz.refresh();
    });
    Quiz.quizActuel = Quiz.quizzes.length-1;
    Navigator.pop(context, 'OK');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  ListQuestion(title: "", quiz: Quiz.get(Quiz.quizzes.length-1))),
    );


  }

  delete(DismissDirection d, int index)async {
    await Quiz.quizzDBHelper.supprimerQuizz(Quiz.quizzes[index].idQuizz);
    setState(() {
      Quiz.quizzes.removeAt(index);
      Quiz.refresh();
    });
  }
}
