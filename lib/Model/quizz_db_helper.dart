
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
const String colonneQuestion_reponse ='qu_reponse';
const String colonneQuestion_quizz ='qu_quizz';
const String colonneQuestion_index ='qu_index';

const String tableReponses = 'reponses';
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
    //_initDatabase();
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
    //await deleteDatabase(path);
    // var exists = await databaseExists(path);
    return await openDatabase(path, version: databaseVersion, onCreate: _open);
  }

  Future _open(Database db, int version) async {
    await db.execute('''
      create table $tableQuestions (
      $colonneQuestion_ID integer primary key autoincrement,
      $colonneQuestion_quizz integer,
      $colonneQuestion_question text,
      $colonneQuestion_reponse integer,
      $colonneQuestion_index integer )
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

    int res =await db.insert(tableQuestions,{colonneQuestion_question:"Le diable de Tasmanie vit dans la jungle du Brésil.",colonneQuestion_quizz:1,colonneQuestion_index:1,colonneQuestion_reponse:2});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"La sauterelle saute l'équivalent de 200 fois sa taille.",colonneQuestion_quizz:1,colonneQuestion_index:2,colonneQuestion_reponse:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"Les pandas hibernent.",colonneQuestion_quizz:1,colonneQuestion_index:3,colonneQuestion_reponse:2});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"On trouve des dromadaires en liberté en Australie.",colonneQuestion_quizz:1,colonneQuestion_index:4,colonneQuestion_reponse:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"Le papillon monarque vole plus de 4000 km.",colonneQuestion_quizz:1,colonneQuestion_index:5,colonneQuestion_reponse:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

    res =await db.insert(tableQuestions,{colonneQuestion_question:"Les gorilles mâles dorment dans les arbres.",colonneQuestion_quizz:1,colonneQuestion_index:6,colonneQuestion_reponse:2});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Vrai",colonneReponse_Question:res,colonneReponse_Index:1});
    await db.insert(tableReponses,{colonneReponse_Reponse:"Faux",colonneReponse_Question:res,colonneReponse_Index:2});

  }

  Future close() async => _db?.close();

  Future<Quiz> getQuizz(int id) async{
    Database? db = await instance.db ;
    List<Map>? maps = await db?.rawQuery ('''SELECT $colonneQuestion_index, $colonneQuizz_Name, $colonneQuestion_ID,$colonneQuestion_reponse,
                                              $colonneQuestion_question,$colonneReponse_Reponse,$colonneReponse_Index
                                              FROM $tableQuizz
                                              LEFT OUTER JOIN $tableQuestions ON $tableQuestions.$colonneQuestion_quizz=$tableQuizz.$colonneQuizz_ID
                                              LEFT OUTER JOIN $tableReponses ON $tableQuestions.$colonneQuestion_ID=$tableReponses.$colonneReponse_Question
                                              ORDER BY $tableQuestions.$colonneQuestion_index,$tableReponses.$colonneReponse_Index''');
    Quiz res = Quiz.empty();
    if (maps != null) {
      if (maps.isNotEmpty) {
        res.nomQuizz=maps[0][colonneQuizz_Name];
        res.idQuizz=id;
        if(maps[0][colonneQuestion_ID]!=null){
          List<Reponse> tmp=[];
          int lastQuestionid = maps[0][colonneQuestion_ID];
          int lastReponse = maps[0][colonneQuestion_reponse];
          int lastIndex = maps[0][colonneQuestion_index];
          String lastQuestion = maps[0][colonneQuestion_question];

          for (Map map in maps) {
            if(lastQuestionid!=map[colonneQuestion_ID]){
              print("Question :$lastQuestion $lastIndex $lastQuestionid");
              res.questions.add(Question(lastQuestion,tmp,lastQuestionid));
              lastQuestionid = map[colonneQuestion_ID];
              lastReponse = map[colonneQuestion_reponse];
              lastQuestion = map[colonneQuestion_question];
              lastIndex = map[colonneQuestion_index];
              tmp =[];
            }
            if(map[colonneReponse_Reponse]!=null){
              tmp.add(Reponse(map[colonneReponse_Reponse].toString(),lastReponse==map[colonneReponse_Index],map[colonneReponse_Index],lastQuestionid));
            }
          }
          print("Question :$lastQuestion $lastIndex $lastQuestionid");
          res.questions.add(Question(lastQuestion,tmp,lastQuestionid));
        }
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

  Future<void> changeIndexQuestion(int idQuizz,int index,int newIndex) async {
    Database? db = await instance.db;
    List<Map>? maps = await db?.rawQuery("SELECT $colonneQuestion_ID FROM $tableQuestions WHERE $colonneQuestion_quizz=$idQuizz AND $colonneQuestion_index=$index");
    if (maps != null) {
      if (maps.isNotEmpty) {

        int idQuestion = maps[0][colonneQuestion_ID];
        if (index > newIndex) {
          await db?.rawUpdate("UPDATE `$tableQuestions` SET $colonneQuestion_index=$colonneQuestion_index+1 WHERE $colonneQuestion_quizz=$idQuizz AND $colonneQuestion_index<$index AND $colonneQuestion_index >=$newIndex");
          int? res = await db?.rawUpdate("UPDATE `questions` SET $colonneQuestion_index=$newIndex WHERE $colonneQuestion_ID=$idQuestion");
        } else {
          await db?.rawUpdate("UPDATE `$tableQuestions` SET $colonneQuestion_index=$colonneQuestion_index-1 WHERE $colonneQuestion_quizz=$idQuizz AND $colonneQuestion_index >$index AND $colonneQuestion_index <=$newIndex");
          await db?.rawUpdate("UPDATE `$tableQuestions` SET $colonneQuestion_index=$newIndex WHERE $colonneQuestion_ID=$idQuestion");
        }
      }
    }
  }

  Future<void> changeQuestion(int idQuestion,String text) async{
    Database? db = await instance.db ;
    await db?.rawUpdate('''UPDATE $tableQuestions SET $colonneQuestion_question='$text' WHERE $colonneQuestion_ID=$idQuestion''');
  }

  Future<void> changeReponseQuestion(Reponse r) async{
    Database? db = await instance.db ;
    await db?.rawUpdate('''UPDATE $tableQuestions SET $colonneQuestion_reponse='${r.index}' WHERE $colonneQuestion_ID=${r.question}''');
  }

  Future<void> ajouterReponseQuestion(int idQuestion,String reponse) async{
    Database? db = await instance.db ;

    List<Map>? maps = await db?.rawQuery("SELECT MAX($colonneReponse_Index) AS max FROM $tableReponses WHERE $colonneReponse_Question=$idQuestion");
    if (maps != null) {
      if (maps.isNotEmpty) {
        int index =1;
        if(maps[0]['max']!=null){
          index = maps[0]['max']+1;
        }
        await db?.insert(tableReponses, {
          colonneReponse_Reponse: reponse,
          colonneReponse_Question: idQuestion,
          colonneReponse_Index: index
        });
      }
    }
  }

  Future <int> ajouterQuestion(int idQuizz, String text) async{
    Database? db = await instance.db ;

    List<Map>? maps = await db?.rawQuery("SELECT MAX($colonneQuestion_index) AS max FROM $tableQuestions WHERE $colonneQuestion_quizz=$idQuizz");
    if (maps != null) {
      if (maps.isNotEmpty) {
        int index =1;
        if(maps[0]['max']!=null){
          index = maps[0]['max']+1;
        }
        return await db!.insert(tableQuestions,{colonneQuestion_question:text,colonneQuestion_quizz:idQuizz,colonneQuestion_index:index,colonneQuestion_reponse:1});
      }
      return await db!.insert(tableQuestions,{colonneQuestion_question:text,colonneQuestion_quizz:idQuizz,colonneQuestion_index:1,colonneQuestion_reponse:1});
    }
    throw Exception("Insertion impossible");
  }

  Future<void> supprimerQuestion(int idQuestion)async{
    Database? db = await instance.db ;
    await db?.delete(tableReponses,where: '$colonneReponse_Question = ?', whereArgs: [idQuestion]);
    await db?.delete(tableQuestions,where: '$colonneQuestion_ID = ?', whereArgs: [idQuestion]);
  }

  Future<void> supprimerReponse(Reponse r)async{
    Database? db = await instance.db ;
    await db?.rawDelete("DELETE FROM $tableReponses WHERE $colonneReponse_Question=${r.question} AND $colonneReponse_Index = ${r.index}");
  }

  Future<void> changeIndexReponse(int idQuestion,int index,int newIndex) async {
    Database? db = await instance.db;

    if (index > newIndex) {
      await db?.rawUpdate("UPDATE $tableReponses SET $colonneReponse_Index = -1 WHERE $colonneReponse_Question = $idQuestion AND $colonneReponse_Index = $index;");
      await db?.rawUpdate("UPDATE $tableReponses SET $colonneReponse_Index =  $colonneReponse_Index +1 WHERE $colonneReponse_Question=$idQuestion AND $colonneReponse_Index < $index AND $colonneReponse_Index >= $newIndex;");
      await db?.rawUpdate("UPDATE $tableReponses SET $colonneReponse_Index = $newIndex WHERE $colonneReponse_Question = $idQuestion AND $colonneReponse_Index = -1");
    } else {
      await db?.rawUpdate("UPDATE $tableReponses SET $colonneReponse_Index = -1 WHERE $colonneReponse_Question = $idQuestion AND $colonneReponse_Index = $index;");
      await db?.rawUpdate("UPDATE $tableReponses SET $colonneReponse_Index =  $colonneReponse_Index -1 WHERE $colonneReponse_Question=$idQuestion AND $colonneReponse_Index <= $newIndex AND $colonneReponse_Index > $index;");
      await db?.rawUpdate("UPDATE $tableReponses SET $colonneReponse_Index = $newIndex WHERE $colonneReponse_Question = $idQuestion AND $colonneReponse_Index = -1");
    }
  }

  Future<int?> ajouterQuizz(String nom)async{
    Database? db = await instance.db;
    int? res=await db?.insert(tableQuizz, {
      colonneQuizz_Name: nom
    });
    return res;
  }

  Future<void> changerNonQuizz(int quizzId,String nom) async{
    Database? db = await instance.db ;
    await db?.rawUpdate('''UPDATE $tableQuizz SET $colonneQuizz_Name='$nom' WHERE $colonneQuizz_ID=$quizzId''');
  }

  Future<void> supprimerQuizz(int quizzId) async{
    Database? db = await instance.db ;
    List<Map>? maps =await db?.rawQuery("SELECT $colonneQuestion_ID FROM $tableQuestions WHERE $colonneQuestion_quizz=$quizzId");

    if (maps != null) {
      if (maps.isNotEmpty) {
        for (Map map in maps) {
          supprimerQuestion(map[colonneQuestion_ID]);
        }
      }
    }
    await db?.delete(tableQuizz,where: '$colonneQuizz_ID = ?', whereArgs: [quizzId]);
  }

}
