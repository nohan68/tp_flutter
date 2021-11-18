

import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';
import 'package:tp_flutter_jaugey_nohan/Model/reponse.dart';

class Question{
   static int questionActuelle = 0;

   List<Reponse> reponses;
   String question;
   int idQuestion;


   Question(this.question,this.reponses,this.idQuestion);

  Reponse getBonneReponse(){
      for(Reponse r in reponses){
         if(r.veracite) {
           return r;
         }
      }
      return Reponse("", false, 0, questionActuelle);
   }

   Reponse getReponse(int i){
      return reponses[i];
   }

   static Question getActuelle(){
      print("actuelle : $questionActuelle");
      return Quiz.getActuel().questions[questionActuelle];
   }

  int getReponseSize() {
    return reponses.length;
  }

  void ajouterReponse(Reponse reponse) {
    reponses.add(reponse);
  }

  void setText(String newText) {
    question = newText;
  }
}