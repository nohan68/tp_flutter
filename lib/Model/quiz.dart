


import 'package:tp_flutter_jaugey_nohan/Model/question.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quizz_db_helper.dart';

class Quiz{
  static int quizActuel = 0;

  static List<Quiz> quizzes = <Quiz>[];
  static QuizzDBHelper quizzDBHelper=QuizzDBHelper.instance;
  List<Question> questions = <Question>[];

  static init() async{
    quizzes = await quizzDBHelper.getQuizzs();
  }


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