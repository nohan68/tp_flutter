
import 'Quiz.dart';
import 'Reponse.dart';

class Question{
   static int questionActuelle = 0;

   List<Reponse> reponses = <Reponse>[];
   String question;

   Question(this.question);

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