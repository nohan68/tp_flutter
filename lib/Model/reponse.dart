
class Reponse{
  String libelle;
  bool veracite;


  Reponse(this.libelle, this.veracite);

  void setVeracite(bool? b) {
    this.veracite = b!;
  }
}