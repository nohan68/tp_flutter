
class Reponse{
  String libelle;
  bool veracite;
  int index;
  int question;


  Reponse(this.libelle, this.veracite,this.index,this.question);

  void setVeracite(bool? b) {
    this.veracite = b!;
  }

  static void deleteReponse(int idQuestion, index) {}

}