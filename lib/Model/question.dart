

import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';
import 'package:tp_flutter_jaugey_nohan/Model/reponse.dart';

class Question{
   static int questionActuelle = 0;

   List<Reponse> reponses;
   String question;
   int idQuestion;


   Question(this.question,this.reponses,this.idQuestion);

  Reponse getBonneReponse(){
      for(Reponse r in this.reponses){
         if(r.veracite)
            return r;
      }
      return new Reponse("", false, 0, questionActuelle);
   }

   Reponse getReponse(int i){
      return this.reponses[i];
   }

   static Question getActuelle(){
      return Quiz.getActuel().questions[questionActuelle];
   }

  int getReponseSize() {
    return this.reponses.length;
  }

  void ajouterReponse(Reponse reponse) {
    this.reponses.add(reponse);
  }

  void setText(String newText) {
    this.question = newText;
  }
}