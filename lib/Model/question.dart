

import 'package:tp_flutter_jaugey_nohan/Model/quiz.dart';
import 'package:tp_flutter_jaugey_nohan/Model/reponse.dart';

class Question{
   static int questionActuelle = 0;

   List<Reponse> reponses;
   String question;


   Question(this.question,this.reponses);

  Reponse getBonneReponse(){
      for(Reponse r in this.reponses){
         if(r.veracite)
            return r;
      }
      throw new Exception("Pas de bonne réponse");
   }

   Reponse getReponse(int i){
      return this.reponses[i];
   }

   static Question getActuelle(){
      return Quiz.getActuel().questions[questionActuelle];
   }
}