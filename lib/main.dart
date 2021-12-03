import 'package:flutter/material.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';
import 'package:tp_flutter_jaugey_nohan/accueil.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Quiz.refresh();

    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
          backgroundColor: const Color.fromRGBO(46, 40, 42,1),
          primaryColor: const Color.fromRGBO(108, 110, 160,1),
          highlightColor: const Color.fromRGBO(200, 200, 213, 0.2),
          unselectedWidgetColor:Colors.white,
          textTheme: const TextTheme(
            bodyText1:TextStyle()
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color.fromRGBO(255, 201, 20,1),
          ),
      ),
      home: Accueil(title: 'Quiz'),
    );
  }
}