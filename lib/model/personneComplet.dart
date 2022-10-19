class PersonneComplet {
  String id;
  String nom;
  String postnom;
  String prenom;
  String sexe;
  String lieu_naissance;
  String date_naissance;
  String etatCiv;
  String residence;
  String telephone;
  String nationalite;
  String province;
  String territoire;
  String photo;

  String categorie;
  String article;
  String place;
  String marcheProvisoire;
  String adresse;

  PersonneComplet(
      {this.id = "",
      this.nom = "",
      this.postnom = "",
      this.prenom = "",
      this.sexe = "",
      this.lieu_naissance = "",
      this.date_naissance = "",
      this.etatCiv = "",
      this.telephone = "",
      this.residence = "",
      this.nationalite = "",
      this.province = "",
      this.territoire = "",
      this.photo = "",
      this.categorie = "",
      this.article = "",
      this.place = "",
      this.marcheProvisoire = "",
      this.adresse = ""});

  factory PersonneComplet.fromJson(Map<String, dynamic> i) => PersonneComplet(
      id: i["id"],
      nom: i["nom"],
      postnom: i["postnom"],
      prenom: i["prenom"],
      sexe: i["sexe"],
      lieu_naissance: i["lieu_naissance"],
      date_naissance: i["date_naissance"],
      etatCiv: i["etat_civil"],
      telephone: i["telephone"],
      residence: i["residence"],
      nationalite: i["nationalite"],
      province: i["province"],
      territoire: i["territoire"],
      photo: i["photo"],
      categorie: i["categorie_id"],
      article: i["article"],
      place: i["type_place"],
      marcheProvisoire: i["marche_provisoire"],
      adresse: i["adresse"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "postnom": postnom,
        "prenom": prenom,
        "sexe": sexe,
        "lieu_naissance": lieu_naissance,
        "date_naissance": date_naissance,
        "etat_civil": etatCiv,
        "telephone": telephone,
        "residence": residence,
        "nationalite": nationalite,
        "province": province,
        "territoire": territoire,
        "photo": photo,
        "categorie_id": categorie,
        "article": article,
        "type_place": place,
        "marche_provisoire": marcheProvisoire,
        "adresse": adresse,
      };
}
