
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:tp_flutter_jaugey_nohan/Model/reponse.dart';
import 'package:tp_flutter_jaugey_nohan/Model/question.dart';
import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';


const String nomBaseDonnees = 'Quizz.db';
const int databaseVersion = 1;

const String tableQuizz = 'quizzs';
const String colonneQuizz_Name ='qz_name';
const String colonneQuizz_ID = 'qz_id';

const String tableQuestions = 'questions';
const String colonneQuestion_question='qu_question';
const String colonneQuestion_ID = 'qu_id';
const String colonneQuesion_reponse ='qu_reponse';
const String colonneQuesion_quizz ='qu_quizz';
const String colonneQuesion_index ='qu_index';

const String tableReponses = 're_reponses';
const String colonneReponse_Question ='re_question';
const String colonneReponse_Reponse ='re_reponse';
const String colonneReponse_Index = 're_index';

class QuizzDBHelper {
  QuizzDBHelper._privateConstructor();

  static final QuizzDBHelper instance = QuizzDBHelper
      ._privateConstructor();

  static Database? _db = null;

  static Future<bool> exists() async {
    return (_db != null);
  }

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initDatabase();
      return _db;
    }
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, nomBaseDonnees);
    // var exists = await databaseExists(path);
    return await openDatabase(path, version: databaseVersion, onCreate: _open);
  }

  Future _open(Database db, int version) async {
    await db.execute('''
      create table $tableQuestions (
      $colonneQuestion_ID integer primary key autoincrement,
      $colonneQuesion_quizz integer,
      $colonneQuestion_question text,
      $colonneQuesion_reponse integer,
      $colonneQuesion_index integer )
      '''
    );
    print('''
      create table $tableQuizz (
      $colonneQuizz_ID integer primary key autoincrement,
      $colonneQuizz_Name text)
      ''');
    await db.execute('''
      create table $tableQuizz (
      $colonneQuizz_ID integer primary key autoincrement,
      $colonneQuizz_Name text)
      '''
    );

    await db.execute('''
      create table $tableReponses (
      $colonneReponse_Question integer,
      $colonneReponse_Reponse integer,
      $colonneReponse_Index integer,
      primary key ($colonneReponse_Question, $colonneReponse_Reponse))
      '''
    );
    await db.insert(tableQuizz, {
      colonneQuizz_Name: "Quizz Animaux",
      colonneQuizz_ID:1
    });

    int res =await db.insert(tableQuestions,{colonneQuestion_question:"Le diable de Tasmanie vit dans la jungle du Brésil.",colonneQuesion_quizz:1,colonneQuesion_index:1,colonneQuesion_reponse:2});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"La sauterelle saute l'équivalent de 200 fois sa taille.",colonneQuesion_quizz:1,colonneQuesion_index:2,colonneQuesion_reponse:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"Les pandas hibernent.",colonneQuesion_quizz:1,colonneQuesion_index:3,colonneQuesion_reponse:2});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"On trouve des dromadaires en liberté en Australie.",colonneQuesion_quizz:1,colonneQuesion_index:4,colonneQuesion_reponse:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"Le papillon monarque vole plus de 4000 km.",colonneQuesion_quizz:1,colonneQuesion_index:5,colonneQuesion_reponse:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"Les gorilles mâles dorment dans les arbres.",colonneQuesion_quizz:1,colonneQuesion_index:6,colonneQuesion_reponse:2});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

  }

  Future close() async => _db?.close();

  Future<Quiz> getQuizz(int id) async{
    Database? db = await instance.db ;
    List<Map>? maps = await db?.rawQuery ('SELECT $tableQuizz.$colonneQuizz_Name, $tableQuestions.$colonneQuestion_ID,$tableQuestions.$colonneQuesion_reponse,$tableQuestions.$colonneQuestion_question,$tableReponses.$colonneReponse_Reponse,$tableReponses.$colonneReponse_Index FROM $tableQuestions LEFT OUTER JOIN $tableQuizz ON $tableQuestions.$colonneQuesion_quizz=$tableQuizz.$colonneQuizz_ID LEFT OUTER JOIN $tableReponses ON $tableQuestions.$colonneQuestion_ID=$tableReponses.$colonneReponse_Question ORDER BY $tableQuestions.$colonneQuesion_index,$tableReponses.$colonneReponse_Index');
    Quiz res = Quiz();
    if (maps != null) {
      if (maps.isNotEmpty) {
        List<Reponse> tmp=[];
        int lastQuestionid = maps[0][colonneQuestion_ID];
        int lastReponse = maps[0][colonneQuesion_reponse];
        String lastQuestion = maps[0][colonneQuestion_question];
        for (Map map in maps) {
          if(lastQuestionid!=map[colonneQuestion_ID]){
            res.questions.add(Question(lastQuestion,tmp));
            lastQuestionid = map[colonneQuestion_ID];
            lastReponse = map[colonneQuesion_reponse];
            lastQuestion = map[colonneQuestion_question];
            tmp =[];
          }
          tmp.add(Reponse(map[colonneReponse_Reponse],lastReponse==map[colonneReponse_Index]));
        }
        res.questions.add(Question(lastQuestion,tmp));
      }
    }
    return res;
  }

  Future<List<Quiz>> getQuizzs() async{
    List<Quiz> res = [];

    Database? db = await instance.db ;
    List<Map>? maps = await db?.query(tableQuizz);

    if (maps != null) {
      if (maps.isNotEmpty) {
        for (Map map in maps) {
          res.add(await getQuizz(map[colonneQuizz_ID]));
        }
      }
    }
    return res;
  }

}
