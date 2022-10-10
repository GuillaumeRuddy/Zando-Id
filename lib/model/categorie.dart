class Categorie {
  String id;
  String nom;

  Categorie({this.id = "", this.nom = ""});

  factory Categorie.fromJson(Map<String, dynamic> i) =>
      Categorie(id: i["id"], nom: i["nom"]);

  Map<String, dynamic> toMap() => {"id": id, "nom": nom};
}
