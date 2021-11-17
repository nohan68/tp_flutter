

import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';
import 'package:tp_flutter_jaugey_nohan/edit_question.dart';

class ListQuestion extends StatefulWidget {
  ListQuestion({Key? key, required this.title, required this.quiz}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  final String title;
  final Quiz quiz;

  @override
  State<ListQuestion> createState() => _SelectState();
suite

class _SelectState extends State<ListQuestion> {

  void select(int i) async{
    Quiz.quizActuel = i;
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  EditQuestion(title: "", question: widget.quiz.getQuestion(i)))
    );
    //TODO mettre setstate avec quizz update
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: widget.quiz.questions.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = widget.quiz.getQuestion(index);

          return ListTile(
            title: Text("${item.question}"),
            subtitle: Text("${item.getBonneReponse().libelle}"),
            onTap: () => { select(index) },
          );
        },
      ),
    );
  }
}
