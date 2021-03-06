
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/list_quiz.dart';
import 'package:tp_flutter_jaugey_nohan/select.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'Model/quiz.dart';

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

  String myTrim(String str){
    String res= str.replaceAll(RegExp(r'(\\t|\\n)+'), '');
    res= res.replaceAll('\\', '');
    res=res.trim();
    return res;
  }

  void telecharger(BuildContext context, String url) async{
    Navigator.pop(context, 'Cancel');
    Fluttertoast.showToast(
        msg: "Téléchargement",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    var uri = Uri.parse(url);
    var response = await http.post(uri);
    String s = const Utf8Codec().decode(response.bodyBytes);
    xml2json.parse(s);
    var jsonData = xml2json.toGData();
    Map<String,dynamic> data = json.decode(jsonData);

    Map<String,dynamic> quizzs = data["Quizzs"];

    for(MapEntry quiz in quizzs.entries){
      List list = quiz.value;
      for(Map iter in list){
        String quizName = iter['type'];
        int idQuizz = await Quiz.quizzDBHelper.ajouterQuizz(quizName);

        List question = iter['Question'];
        for(Map item in question){
          String questionText = myTrim(item['\$t'].trim());
          int indexReponse = int.parse(item['Reponse']['valeur'][0]);

          int idQuestion = await Quiz.quizzDBHelper.ajouterQuestion(idQuizz, questionText,indexReponse: indexReponse);
          List reponses = item['Propositions']['Proposition'];
          for(Map reponse in reponses){
            String rep = myTrim(reponse['\$t'].trim());
            await Quiz.quizzDBHelper.ajouterReponseQuestion(idQuestion, rep);
          }
        }

        print("\n++++++++++++++++++++++++\n");
      }
      print("\n--------------------------\n");
      Quiz.refresh();

      Fluttertoast.showToast(
          msg: "Quiz(s) téléchargé(s)",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(20),
                    child:ElevatedButton(
                      onPressed: () => {jouer(context)}, child: const Text("Jouer"),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          textStyle:const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold)
                          ),
                    ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                    child:ElevatedButton(
                        onPressed: () => {modifierQuestions(context)}, child: const Text("Modifier les Quizs"),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          textStyle:const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold)

                      ),
                    ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                    child:ElevatedButton(
                        onPressed: () => {popUpDownload(context)}, child: const Text("Télécharger"),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          textStyle:const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold)
                      ),
                    )
              ),
                  ]
              )
      )
    );
  }
}