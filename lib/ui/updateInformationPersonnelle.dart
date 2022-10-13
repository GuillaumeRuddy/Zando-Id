import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zando_id/model/categorie.dart';
import 'package:zando_id/model/personne.dart';
import 'package:zando_id/ui/activite.dart';
import 'package:zando_id/ui/success.dart';
import 'package:zando_id/widgets/ButtonWANGI.dart';
import 'package:http/http.dart' as http;

//import 'package:image/image.dart' as ImageProcess;

class UpdateInformationPersonnellePage extends StatefulWidget {
  final String idUser;
  final String userName;
  final String nom;
  final String postnom;
  final String prenom;
  final String sexe;
  final String lieuNais;
  final String dateNais;
  final String etatcivile;
  final String adresse;
  final String telephone;
  final String nationalite;
  final String province;
  final String territoire;
  final String agent;
  final String residence;
  //UpdateInformationPersonnellePage({Key? key}) : super(key: key);
  UpdateInformationPersonnellePage(
      {Key? key,
      required this.idUser,
      required this.userName,
      required this.nom,
      required this.postnom,
      required this.prenom,
      required this.sexe,
      required this.lieuNais,
      required this.dateNais,
      required this.etatcivile,
      required this.adresse,
      required this.telephone,
      required this.nationalite,
      required this.province,
      required this.territoire,
      required this.agent,
      required this.residence})
      : super(key: key);

  @override
  _UpdateInformationPersonnellePageState createState() =>
      _UpdateInformationPersonnellePageState();
}

class _UpdateInformationPersonnellePageState
    extends State<UpdateInformationPersonnellePage> {
  bool _loading = false;
  TextEditingController nomController = TextEditingController(); //good
  TextEditingController postnomController = TextEditingController(); //good
  TextEditingController prenomController = TextEditingController(); //good
  TextEditingController villeNaissanceController =
      TextEditingController(); //good
  TextEditingController professionController = TextEditingController(); //good
  TextEditingController residenceController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController nationaliteController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController territoireController = TextEditingController();

  TextEditingController adresseController = TextEditingController(); //good
  TextEditingController marcheController = TextEditingController(); //good
  TextEditingController articleController = TextEditingController(); //good

  void miseDonne() {
    nomController.text = widget.nom;
    postnomController.text = widget.postnom; //good
    prenomController.text = widget.prenom;
    villeNaissanceController.text = widget.dateNais;
    residenceController.text = widget.adresse;
    telephoneController.text = widget.telephone;
    nationaliteController.text = widget.nationalite;
    provinceController.text = widget.nationalite;
    territoireController.text = widget.territoire;
  }

  //GlobalKey<ScaffoldState> cle = GlobalKey();
  var selectedcategorie; //good
  var selectTypeplace; //good
  var typePlace = null, typeategorie = null;
  var categorieRecup;

  //liste des categories dans item
  List<DropdownMenuItem<String>> listCategorie = [];

  //liste des categories dans api
  List<Categorie> listCat = [];

  //liste des typeplace dans item
  List<DropdownMenuItem<String>> listPlace = [];

  void place() {
    listPlace.clear();
    listPlace.add(
      DropdownMenuItem(
        value: 'Maison commerciale',
        child: Text(
          'Maison',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
    listPlace.add(
      DropdownMenuItem(
        value: 'Etallage',
        child: Text(
          'Etallage',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
    print('********* liste de place **********');
    print(listPlace);
    print('********* fin liste de place **********');
  }

  // ignore: non_constant_identifier_names
  void category() {
    listCategorie.clear();
    print("*********** dans le netoyage de la dropdown categorie ***********");
    for (Categorie cat in listCat) {
      listCategorie.add(
        DropdownMenuItem(
          value: cat.id.toString(),
          child: Text(
            cat.nom,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      );
    }
    print('********* liste de categorie **********');
    print(listCategorie);
    print('********* fin liste de categorie **********');
  }

  DateTime tgl = new DateTime.now();
  late DateTime dateNaiss;
  DateTime _selectedDate = DateTime.now();

  GlobalKey<ScaffoldState> key = GlobalKey();

  String maDateNaissance = 'Appuyez ici'; //good, celle utiliser
  String _datenaissance = ""; //good
  var image_file; //good
  String nom = "", postnom = "", prenom = "";
  // String adresse2, email, numeroCarte, nmbreEnfant, region;
  String groupValue = ""; //good
  String tel = ""; //good
  String pays = ""; // goog ---utiliser directements sur le widget
  String profession = ""; //good
  String sexe = ""; //good
  String ville = ""; //goog
  var etatC = null; //good
  String photoIdent = "";
  var utilisateur = "";
  String idUser = "";

  List<DropdownMenuItem<String>> listEtat = [];

  void etatCiv() {
    listEtat.clear();
    listEtat.add(
      DropdownMenuItem(
        value: 'Célibataire',
        child: Text(
          'Célibataire',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
    listEtat.add(
      DropdownMenuItem(
        value: 'Marié',
        child: Text(
          'Marié',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
    listEtat.add(
      DropdownMenuItem(
        value: 'Divorce',
        child: Text(
          'Divorce',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
    listEtat.add(
      DropdownMenuItem(
        value: 'Séparer',
        child: Text(
          'Séparer',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
    listEtat.add(
      DropdownMenuItem(
        value: 'veuf/veuve',
        child: Text(
          'Veuf/veuve',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  void showSnackbar(String titre) {
    final snackbar = SnackBar(
      content: Text(
        titre,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    key.currentState?.showSnackBar(snackbar);
  }

  void toast(String msag) {
    Fluttertoast.showToast(
        msg: msag,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2);
  }

  Future _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    utilisateur = prefs.getString("user").toString();
    print('Ce que je vient de recuperer comme user :  ##### ' + utilisateur);
  }

  Future recupCategorie() async {
    //Debut Test de connection, pour voir si l'utilisateur est connecter
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      //S'il est connecter on vas vers l'API ici...
      try {
        final response = await http.get(
            Uri.parse(
                "http://zando-app.e-entrepreneurdrc.com/zando_api/public/api/categories"),
            headers: <String, String>{
              "Content-type": "application/json; chartset=UTF-8"
            }).timeout(const Duration(seconds: 20), onTimeout: () {
          //<----Gestion du time out dans le cas ou sa prend trop de temps
          print(" ******  tozo zela  ****** ");
          showSnackbar(
              "Delais d'attente depasser, veuillez reessaie plus tard");
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        print(" ******  response  ****** ");
        if (response.statusCode == 200) {
          print(" ******  200  ****** ");
          //<------ Teste si la requette vers l'API marche
          categorieRecup = jsonDecode(response
              .body); //<---- recuperation des données qui sont en format JSON
          print("les datas que recupere *********** " +
              categorieRecup.toString());

          //ici je fais les opérations de json vers dropdownbutton
          if (categorieRecup != null) {
            listCat.clear();
            print("je viens de cean avant fur *********** ");
            for (var i in categorieRecup) {
              print(i);
              print(" ce de dessus cest les infos ");
              Map<String, dynamic> catg = {
                "id": i["id"].toString(),
                "nom": i["nom"].toString(),
              };
              print("###### la categorie en MMMAP ######");
              print(catg);
              print("###### la categorie en processus de OBJET ######");
              Categorie categor = Categorie.fromJson(catg);
              print("###### la categorie apres fin process OBJET ######");
              print(categor.id);
              print(categor.nom);
              print("###### la categorie en mode AJOUT dans liste ######");
              listCat.add(categor);
              print("###### la categorie en mode fin ajout ######");
              /*setState(() {
                listCat.add(Categorie.fromJson(catg));
              });*/
            }
            print("###### les categories recuperes en objets ######");
            print(listCat);
          }
          category();

          //fin opération
        } else {
          print(response.statusCode);
          var msg = "Impossible de recuperer les informations de la catégorie";
          setState(() {
            showSnackbar(msg);
          });
        }
      } on SocketException {
        setState(() {
          showSnackbar(
              "Nous rencontrons un problème, veuillez réessaie ulterieuement");
        });
      } on TimeoutException {
        setState(() {
          showSnackbar("Delais d'attente dépasser");
        });
      } catch (e) {
        print("erreur: $e");
        setState(() {
          showSnackbar("Nous rencontrons un problème $e");
        });
      }
    } else {
      setState(() {
        toast("Impossible de se connecter à internet");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPreferences();
    recupCategorie();
    miseDonne();
  }

  @override
  Widget build(BuildContext context) {
    category();
    place();
    etatCiv();
    return Scaffold(
      appBar: AppBar(
        title: Text("Mise à jour Identité"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      key: key,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //utilisateur connecter
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Utilisateur connecté : ",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.userName == null || widget.userName.isEmpty
                        ? ''
                        : widget.userName.toUpperCase(),
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Divider(
                height: 10,
              ),
              SizedBox(
                height: 5,
              ),
              // nom (nomController)
              TextField(
                controller: nomController,
                decoration: InputDecoration(
                    hintText: 'Nom',
                    labelText: 'Nom',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              //postnom (postnomController)
              TextField(
                controller: postnomController,
                decoration: InputDecoration(
                    hintText: widget.postnom,
                    labelText: 'Postnom',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              // prenom (prenomController)
              TextField(
                controller: prenomController,
                decoration: InputDecoration(
                    hintText: widget.prenom,
                    labelText: 'Prenom',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sexe",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  //Radio Homme
                  Radio(
                      value: "M",
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          this.groupValue = value.toString();
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "M",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  //Radio Femme
                  Radio(
                      value: "F",
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          this.groupValue = value.toString();
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "F",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Lieu de naissance
              TextField(
                controller: villeNaissanceController,
                decoration: InputDecoration(
                    hintText: 'Lieu de naissance',
                    labelText: 'Lieu de naissance',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                //date de naissance
                Text(
                  "Date de naissance",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                //bouton date de naissance
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                    ),
                    onPressed: () {
                      monCalendrier();
                    },
                    child: Text("${maDateNaissance}")),
              ]),
              SizedBox(
                height: 10,
              ),
              // etat civil
              Row(
                children: [
                  Text(
                    "Etat civil",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton(
                      value: etatC,
                      elevation: 10,
                      items: listEtat,
                      hint: Text(
                        'Sélectionnez l\'état civil',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      onChanged: (value) {
                        etatC = value.toString();
                        setState(() {});
                      }),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Residence
              TextField(
                controller: residenceController,
                decoration: InputDecoration(
                    hintText: 'Residence',
                    labelText: 'Residence',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              // Telephone
              TextField(
                controller: telephoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: 'Télephone',
                    labelText: 'Téléphone',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              // Nationalite
              TextField(
                controller: nationaliteController,
                decoration: InputDecoration(
                    hintText: 'Nationalité',
                    labelText: 'Nationalité',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              // province
              TextField(
                controller: provinceController,
                decoration: InputDecoration(
                    hintText: 'Province',
                    labelText: 'Province',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 10,
              ),
              // Territpoire
              TextField(
                controller: territoireController,
                decoration: InputDecoration(
                    hintText: 'Territoire',
                    labelText: 'Territoire',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),
              SizedBox(
                height: 25,
              ),
              //prendre une photo
              Text(
                "Veuillez prendre une photo de vous sur fond blanc en format passeport",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Card(
                elevation: 1,
                child: Container(
                  child: image_file == null
                      ? Image.asset("assets/visage.png", fit: BoxFit.fill)
                      : Image.file(
                          image_file,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () {
                    menuContextuel(context);
                  },
                  child: Text("Prendre une photo")),
              SizedBox(
                height: 40,
              ),
              // categorie
              Row(
                children: [
                  Text(
                    "Catégorie",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton(
                      value: typeategorie,
                      elevation: 10,
                      items: listCategorie,
                      hint: Text(
                        'Sélectionnez la categorie',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      onChanged: (value) {
                        typeategorie = value.toString();
                        setState(() {});
                      }),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              // Article (articleController)
              TextField(
                controller: articleController,
                decoration: InputDecoration(
                    hintText: 'Article',
                    labelText: 'Article',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),

              SizedBox(
                height: 10,
              ),

              //type place
              Row(
                children: [
                  Text(
                    "Type place",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton(
                      value: typePlace,
                      elevation: 20,
                      items: listPlace,
                      hint: Text(
                        'Sélectionnez le type',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      onChanged: (value) {
                        typePlace = value;
                        setState(() {});
                      }),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              //marché provisoire (marcheController)
              TextField(
                controller: marcheController,
                decoration: InputDecoration(
                    hintText: 'Marche provisoire',
                    labelText: 'Marche provisiore',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),

              SizedBox(
                height: 10,
              ),

              // nom (nomController)
              TextField(
                controller: adresseController,
                decoration: InputDecoration(
                    hintText: 'Adresse',
                    labelText: 'Adresse',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1))),
              ),

              SizedBox(
                height: 30,
              ),

              // Bouton de validation
              ButtonWANGI(
                titre: 'Enregistrer',
                color: Colors.green,
                onPressed: () {
                  authentificaion(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void authentificaion(context) {
    if (nomController.text == '') {
      showSnackbar('Veuillez remplir le nom svp !');
    } else if (postnomController.text == '') {
      showSnackbar('Veuillez remplir le postnom svp !');
    } else if (prenomController.text == '') {
      showSnackbar('Veuillez remplir le prenom svp !');
    } else if (nationaliteController.text == '') {
      showSnackbar('Veuillez remplir la nationalite Svp !');
    } else if (maDateNaissance == '') {
      showSnackbar('Veuillez selectionner la date de naissance Svp !');
    } else if (villeNaissanceController.text == '') {
      showSnackbar('Veuillez remplir la ville de naissance Svp !');
    } else if (etatC == '') {
      showSnackbar('Veuillez selectionner l\'etat civil Svp !');
    } else if (residenceController.text == '') {
      showSnackbar('Veuillez remplir l\'adresse Svp !');
    } else if (provinceController.text == '') {
      showSnackbar('Veuillez remplir la province Svp !');
    } else if (territoireController.text == '') {
      showSnackbar('Veuillez remplir le territoire Svp !');
    } else if (groupValue == '') {
      showSnackbar('Veuillez choisir le sexe Svp !');
    } else if (photoIdent == '') {
      showSnackbar('Veuillez ajouter une photo Svp !');
    } else if (adresseController.text == '') {
      showSnackbar('Veuillez remplir l\'adresse svp !');
    } else if (marcheController.text == '') {
      showSnackbar('Veuillez remplir le marché provisioire svp !');
    } else if (articleController.text == '') {
      showSnackbar('Veuillez remplir l\'article Svp !');
    } else if (typePlace == '') {
      showSnackbar('Veuillez selectionner la place Svp !');
    } else if (typeategorie == '') {
      showSnackbar('Veuillez selectionner la categorie Svp !');
    } else {
      enregistrement(
        nomController.text,
        postnomController.text,
        prenomController.text,
        groupValue,
        villeNaissanceController.text,
        maDateNaissance,
        etatC,
        adresseController.text,
        telephoneController.text,
        nationaliteController.text,
        provinceController.text,
        territoireController.text,
        widget.userName,
        adresseController.text,
        marcheController.text,
        articleController.text,
        typePlace,
        typeategorie,
      );
    }
    {
      //seconde page
      if (dateNaiss.isBefore(tgl)) {
        saveInfosPersonnel();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Activite(user: utilisateur)));
      } else {
        showSnackbar("veuillez renseigner une bonne date");
      }
    }
  }

  //capture
  capturePhoto(ImageSource source) async {
    final imagePath = await ImagePicker()
        .getImage(source: source, maxWidth: 400, maxHeight: 400);
    if (imagePath != null) {
      setState(() {
        image_file = File(imagePath.path);
        File photo = File(imagePath.path);
        photoIdent = base64Encode(photo.readAsBytesSync());
        print(
            ' ###### la phot convertie lors de la capture :  ########  *****   ' +
                photoIdent);
        //sauvegarde de l'image
        //stockage dans préférence
        //Utile.saveImagePreference("TS",Utile.imageBase64(image_file));
      });
    }
  }

  //button sheet   ---- pour la photo ----
  menuContextuel(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctxt) {
          return Wrap(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Prendre une photo",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Divider(
                      height: 2,
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt_outlined),
                      title: Text(
                        "Caméra",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        capturePhoto(ImageSource.camera);
                      },
                    ),
                    ListTile(
                        leading: Icon(Icons.camera_alt_outlined),
                        title: Text(
                          "Gallery",
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          capturePhoto(ImageSource.gallery);
                        }),
                  ],
                ),
              )
            ],
          );
        });
  }

  //calendrier
  Future<Null> monCalendrier() async {
    DateTime? choixDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1945),
        lastDate: DateTime(2050));

    if (choixDate != null && choixDate != tgl) {
      print("choix date naissance: $choixDate");
      _datenaissance = choixDate.toString();
      setState(() {
        maDateNaissance = _datenaissance;
        maDateNaissance = maDateNaissance.substring(0, 10);
        dateNaiss = DateTime.parse(maDateNaissance);
      });
    }
  } //fin widget

  Future enregistrement(
      String nom,
      String postnom,
      String prenom,
      String sexe,
      String lieuNais,
      String dateNais,
      String etatcivile,
      String adresse,
      String telephone,
      String nationalite,
      String province,
      String territoire,
      String agent,
      String residence,
      String marchePro,
      String article,
      String place,
      String categorie) async {
    //Debut Test de connection, pour voir si l'utilisateur est connecter
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(" ******  Nous sommes dans le check internet   ****** ");
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      //S'il est connecter on vas vers l'API ici...
      setState(() {
        _loading = true;
      });
      try {
        print(" ******  debut try   ****** ");
        final response = await http
            .put(
                Uri.parse(
                    "http://zando-app.e-entrepreneurdrc.com/zando_api/public/api/personnes/id"),
                headers: <String, String>{
                  "Content-type": "application/json; chartset=UTF-8"
                },
                body: jsonEncode(<String, String>{
                  "nom": nom,
                  "postnom": postnom,
                  "prenom": prenom,
                  "sexe": sexe,
                  "lieu_naissance": lieuNais,
                  "date_naissance": dateNais,
                  "etat_civil": etatcivile,
                  "residence": adresse,
                  "telephone": telephone,
                  "nationalite": nationalite,
                  "province": province,
                  "territoire": territoire,
                  "categorie_id": categorie,
                  "agent_id": agent,
                  "position": "128'89 087'474",
                  "type_place": place,
                  "adresse": residence,
                  "marche_provisoire": marchePro,
                  "article": article
                }))
            .timeout(const Duration(seconds: 20), onTimeout: () {
          //<----Gestion du time out dans le cas ou sa prend trop de temps
          print(" ******  tozo zela  ****** ");
          showSnackbar(
              "Delais d'attente depasser, veuillez reessaie plus tard");
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        print(" ******  response  ****** ");
        if (response.statusCode == 200) {
          print(" ******  200  ****** ");
          //<------ Teste si la requette vers l'API marche
          var data = jsonDecode(response
              .body); //<---- recuperation des données qui sont en format JSON
          print("les datas que recupere *********** " + data.toString());

          var retour = data["status"];
          if (retour == "success") {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Success()));

            setState(() {
              //showSnackbar("Vendeur Enregistrer");
              bool _loading = false;
            });
          }
          //ici tu met la redirection en fonction de l'action qui vas suivre...
        } else {
          print(response.statusCode);
          var msg = "un Problème se pose dans les informations fournies";
          setState(() {
            showSnackbar(msg);
          });
        }
      } on SocketException {
        setState(() {
          showSnackbar(
              "Nous rencontrons un problème, veuillez réessaie ulterieuement");
        });
      } on TimeoutException {
        setState(() {
          showSnackbar("Delais d'attente dépasser");
        });
      } catch (e) {
        print("erreur: $e");
        setState(() {
          showSnackbar("Nous rencontrons un problème $e");
        });
      }
    } else {
      setState(() {
        toast("Impossible de se connecter à internet");
      });
    }
  }

  //Sauvegarde dans le préférence
  Future saveInfosPersonnel() async {
    print('############## Inside savepref #################');

    nom = nomController.text;
    postnom = postnomController.text;
    prenom = prenomController.text;
    sexe = groupValue;
    _datenaissance = maDateNaissance;

    // debut sauvegarde données
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nom', nom);
    prefs.setString('postnom', postnom);
    prefs.setString('prenom', prenom);
    prefs.setString('sexe', sexe);
    prefs.setString('dateNaissance', _datenaissance);
    prefs.setString('lieuNaissance', villeNaissanceController.text);
    prefs.setString('etatCivil', etatC);
    prefs.setString('residence', residenceController.text);
    prefs.setString('telephone', telephoneController.text);
    prefs.setString('nationalite', nationaliteController.text);
    prefs.setString('province', provinceController.text);
    prefs.setString('territoire', territoireController.text);
    prefs.setString('photoIdent', photoIdent);
  } //fin savepref

}
