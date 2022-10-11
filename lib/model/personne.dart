class Personne {
  String id;
  String nom;
  String postnom;
  String prenom;
  String sexe;
  String lieu_naissance;
  String date_naissance;
  String residence;
  String telephone;
  String nationalite;
  String province;
  String territoire;
  String photo;

  Personne(
      {this.id = "",
      this.nom = "",
      this.postnom = "",
      this.prenom = "",
      this.sexe = "",
      this.lieu_naissance = "",
      this.date_naissance = "",
      this.telephone = "",
      this.residence = "",
      this.nationalite = "",
      this.province = "",
      this.territoire = "",
      this.photo = ""});

  factory Personne.fromJson(Map<String, dynamic> i) => Personne(
      id: i["id"],
      nom: i["nom"],
      postnom: i["postnom"],
      prenom: i["prenom"],
      sexe: i["sexe"],
      lieu_naissance: i["lieu_naissance"],
      date_naissance: i["date_naissance"],
      telephone: i["telephone"],
      residence: i["residence"],
      nationalite: i["nationalite"],
      province: i["province"],
      territoire: i["territoire"],
      photo: i["photo"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "postnom": postnom,
        "prenom": prenom,
        "sexe": sexe,
        "lieu_naissance": lieu_naissance,
        "date_naissance": date_naissance,
        "telephone": telephone,
        "residence": residence,
        "nationalite": nationalite,
        "province": province,
        "territoire": territoire,
        "photo": photo
      };
}
