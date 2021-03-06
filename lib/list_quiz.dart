

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
  String editTitre = "";

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
      backgroundColor: Theme.of(context).backgroundColor,

      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: Quiz.quizzes.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = Quiz.get(index);
          return Dismissible(
              background: Row(
                children:[
                  Expanded(
                    flex: 5,

                    child:Container(
                      alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [
                              0.6,
                              1,
                            ],
                            colors: [
                              Colors.indigo,
                              Colors.black,
                            ],
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          child: Icon(IconData(0xe3f2, fontFamily: 'MaterialIcons'),
                            color: Colors.white,

                          ),


                        ),
                      ),
                  ),
              Expanded(
                  flex: 5,
                child:Container(
                  alignment: Alignment.centerRight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: [
                        0.6,
                        1,
                      ],
                      colors: [
                        Colors.red,
                        Colors.black,
                      ],
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Icon(Icons.delete,
                      color: Colors.white,

                    ),


                  ),
                ),
              ),
              ]
              ),
              key: Key(item.nomQuizz),
              child: ListTile(
                  title:  Text(item.nomQuizz,
                      style:const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ).apply(
                        color: Colors.white,
                      )),
                  subtitle: Text("Nombre de questions : ${item.questions.length}",
                      style:const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ).apply(
                        color: Theme.of(context).colorScheme.secondary,
                      )
                  ),
                  onTap: () => { select(index) }
              ),
              onDismissed: (d) => {delete(d, index)}
          );

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
    Quiz nouveauQuiz = Quiz(res, nouveauTitre);

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

  delete(DismissDirection d, int index) async {
    if(d ==  DismissDirection.endToStart){
      await Quiz.quizzDBHelper.supprimerQuizz(Quiz.quizzes[index].idQuizz);
      setState(() {
        Quiz.quizzes.removeAt(index);
        Quiz.refresh();
      });
    }

    if(d == DismissDirection.startToEnd) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: const Text('Editer le quiz'),
                actions: <Widget>[
                  Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Entrez le nouveau nom",
                            ),
                            onChanged: (String s) =>
                            {
                              widget.editTitre = s
                            },
                          )
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () =>
                            {
                              Navigator.pop(context, 'Cancel')
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () =>
                            {
                              edit(widget.editTitre, index)
                            },
                            child: const Text('Modifier'),
                          ),
                        ],
                      )
                    ],
                  )

                ],
              )
      );
    }

  }

  edit(String editTitre, int index) {
    Quiz.get(index).setNom(editTitre);
    setState(() {

    });
    Navigator.pop(context, 'Cancel');
  }
}
