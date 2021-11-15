


import 'package:tp_flutter_jaugey_nohan/Model/Question.dart';

class Quiz{
  static int quizActuel = 0;

  static List<Quiz> quizzes = <Quiz>[];
  List<Question> questions = <Question>[];


  static get(int i){
    return Quiz.quizzes[i];
  }

  static add(Quiz quiz){
    quizzes.add(quiz);
  }
  static clear(){
    quizzes = <Quiz>[];
  }

  static Quiz getActuel(){
    return Quiz.quizzes[Quiz.quizActuel];
  }

  Question getQuestion(int i){
    return this.questions[i];
  }





}