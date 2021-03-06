

import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';
import 'jeu.dart';

class Select extends StatefulWidget {
  Select({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  final String title;

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {



  void select(int i){
    Quiz.quizActuel = i;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  Jeu(title: ""))
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

                    return ListTile(
                      title: Text(item.nomQuizz,
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
                      onTap: () => { select(index) },
                    );
                  },
                ),
        );
  }

  @override
  void initState() {
    super.initState();
    Quiz.refresh();
  }
}
