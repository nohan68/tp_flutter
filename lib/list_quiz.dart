

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

  @override
  State<ListQuiz> createState() => _SelectState();
}

class _SelectState extends State<ListQuiz> {

  void select(int i){
    Quiz.quizActuel = i;
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ListQuestion(title: "", quiz: Quiz.get(i)))
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

          return ListTile(
            title: Text("Quiz $index"),
            subtitle: Text("$index"),
            onTap: () => { select(index) },
          );
        },
      ),
    );
  }
}
