import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:zando_id/model/categorie.dart';
import 'package:zando_id/ui/success.dart';
import 'package:zando_id/widgets/ButtonWANGI.dart';
import 'package:zando_id/widgets/loading.dart';

import 'informationPersonnelle.dart';

//import 'package:image/image.dart' as ImageProcess;

class Activite extends StatefulWidget {
  String user = "";
  Activite({Key? key, required this.user}) : super(key: key);

  @override
  _ActiviteState createState() => _ActiviteState();
}

class _ActiviteState extends State<Activite> {
  bool _loading = false;
  TextEditingController adresseController = TextEditingController(); //good
  TextEditingController marcheController = TextEditingController(); //good
  TextEditingController articleController = TextEditingController(); //good

  var nom, postnom, prenom, sexe, dateNaissance, lieuNaissance;
  var adresse, telephone, nationalite, province, territoire, photo;
  var agent, etatCiv;
  var selectedcategorie; //good
  var selectTypeplace; //good
  var utilisateur = "";
  var typePlace = null, typeategorie = null;
  var categorieRecup;

  Future getInfosPersonnel() async {
    print('############## Inside getpref #################');

    // debut récuperation données
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nom = prefs.getString('nom');
    postnom = prefs.getString('postnom');
    prenom = prefs.getString('prenom');
    sexe = prefs.getString('sexe');
    dateNaissance = prefs.getString('dateNaissance');
    lieuNaissance = prefs.getString('lieuNaissance');
    etatCiv = prefs.getString('etatCivil');
    adresse = prefs.getString('residence');
    telephone = prefs.getString('telephone');
    nationalite = prefs.getString('nationalite');
    province = prefs.getString('province');
    territoire = prefs.getString('territoire');
    photo = prefs.getString('photoIdent');
    agent = prefs.getString('id_user');
  }

  GlobalKey<ScaffoldState> key = GlobalKey();

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

  void _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    utilisateur = prefs.getString('user')!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPreferences();
    recupCategorie();
    getInfosPersonnel();
  }

  @override
  Widget build(BuildContext context) {
    category();
    place();
    return _loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Informations Activité"),
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
                          widget.user == null || widget.user.isEmpty
                              ? ''
                              : widget.user,
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
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
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1))),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
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
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1))),
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
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1))),
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
    if (adresseController.text == '') {
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
        nom,
        postnom,
        prenom,
        sexe,
        lieuNaissance,
        dateNaissance,
        etatCiv,
        adresse,
        telephone,
        nationalite,
        province,
        territoire,
        agent,
        adresseController.text,
        marcheController.text,
        articleController.text,
        typePlace,
        typeategorie,
      );
    }
  }

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
            .post(
                Uri.parse(
                    "http://zando-app.e-entrepreneurdrc.com/zando_api/public/api/personnes"),
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
}
