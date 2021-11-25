
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/list_quiz.dart';
import 'package:tp_flutter_jaugey_nohan/select.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

class Accueil extends StatelessWidget{
  var title;
  String url = "https://dept-info.univ-fcomte.fr/joomla/images/CR0700/Quizzs.xml";
  Xml2Json xml2json = Xml2Json();

  Accueil({Key? key, required this.title}) : super(key: key);

  void jouer(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  Select(title: title)),
    );
  }

  void telecharger(BuildContext context, String url) async{
    var uri = Uri.parse(url);
    var response = await http.post(uri);
    xml2json.parse(response.body);
    var jsonData = xml2json.toGData();
    Map<String,dynamic> data = json.decode(jsonData);

    Map<String,dynamic> quizzs = data["Quizzs"];

    for(var quiz in quizzs.entries){
      print(quiz);
    }
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
  }

  void popUpDownload(BuildContext context){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Téléchargement'),
        actions: <Widget>[
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Entrez l'url de téléchargement",
                    ),
                    onChanged: (String s)=>{
                      url = s
                    },
                    initialValue: "https://dept-info.univ-fcomte.fr/joomla/images/CR0700/Quizzs.xml",
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
                      telecharger(context, url)
                    },
                    child: const Text('Ajouter'),
                  ),
                ],
              )
            ],
          )

        ],
      ),
    );
  }


  void modifierQuestions(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ListQuiz(title: ""))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              ElevatedButton(onPressed: () => {jouer(context)}, child: Text("Jouer")),
              ElevatedButton(onPressed: () => {modifierQuestions(context)}, child: Text("Modifier les Quizzes")),
              ElevatedButton(onPressed: () => {popUpDownload(context)}, child: Text("Télécharger"))
                  ]
              )
      )
    );
  }
}