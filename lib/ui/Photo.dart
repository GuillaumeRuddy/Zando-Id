import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:zando_id/ui/success.dart';

import '../widgets/ButtonWANGI.dart';

class Photo extends StatefulWidget {
  String? user;
  Photo({Key? key, this.user}) : super(key: key);

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  var image_file;
  File? photo;
  bool _loading = false;

  var nom, postnom, prenom, sexe, dateNaissance, lieuNaissance;
  var adresse, telephone, nationalite, province, territoire;
  var agent, etatCiv, commune;
  var utilisateur = "";
  var typePlace = null, typeategorie = null;
  var categorieRecup;
  var localisation;
  var adresseVente, marche, article;

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
    commune = prefs.getString('commune');
    adresse = prefs.getString('residence');
    telephone = prefs.getString('telephone');
    nationalite = prefs.getString('nationalite');
    province = prefs.getString('province');
    territoire = prefs.getString('territoire');
    agent = prefs.getString('id_user');
    adresseVente = prefs.getString("adresseVente");
    marche = prefs.getString("marchProv");
    article = prefs.getString("article");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfosPersonnel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Photo",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        body: SafeArea(
            child: Column(
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
                  widget.user == null || widget.user!.isEmpty
                      ? ''
                      : widget.user!.toUpperCase(),
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
            Text(
              "Veuillez prendre une photo de vous sur fond blanc en format passeport",
              style: GoogleFonts.poppins(
                color: Color.fromARGB(255, 14, 191, 20),
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
                height: 400,
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
            ButtonWANGI(
              titre: 'Enregistrer',
              color: Colors.green,
              onPressed: () {
                validation(context);
              },
            ),
          ],
        )));
  }

  //capture
  capturePhoto(ImageSource source) async {
    final imagePath = await ImagePicker()
        .getImage(source: source, maxWidth: 500, maxHeight: 500);
    if (imagePath != null) {
      setState(() {
        image_file = File(imagePath.path);
        photo = File(imagePath.path);
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
  // fin photo

  void validation(context) {
    if (photo == '') {
      showSnackbar('Veuillez prendre une photo svp !');
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
          commune,
          telephone,
          nationalite,
          province,
          territoire,
          agent,
          adresseVente,
          marche,
          article,
          "Etalage",
          "cat1",
          photo!);
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
      String commune,
      String telephone,
      String nationalite,
      String province,
      String territoire,
      String agent,
      String residence,
      String marchePro,
      String article,
      String place,
      String categorie,
      File photo) async {
    //Debut Test de connection, pour voir si l'utilisateur est connecter
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(" ******  Nous sommes dans le check internet   ****** ");
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      //S'il est connecter on vas; vers l'API ici...
      setState(() {
        _loading = true;
      });
      try {
        print(" ******  debut try   ****** ");
        print(" ******  debut Photo  ****** ");
        print(photo);
        print(" ******  fin photo  ****** ");
        print(
            "**** nom: $nom ***** postnom: $postnom ***** prenom: $prenom **** sexe: $sexe **** lieuNais: $lieuNaissance **** date: $dateNais **** etatciv: $etatcivile **** residence: $adresse **** telephone: $telephone **** nationalite: $nationalite **** province: $province **** categorie : $categorie **** agent id: $agent **** place: $place **** adresse : $residence **** marcheprov: $marchePro **** article: $article **** ");
        var url = Uri.parse("https://ageas-cenco.com/zd/public/api/personnes");
        print(url);
        var request = http.MultipartRequest("Post", url);
        print("-------- La requette 1: ${request}");

        request.fields["nom"] = nom;
        request.fields["postnom"] = postnom;
        request.fields["prenom"] = prenom;
        request.fields["sexe"] = sexe;
        request.fields["lieuNais"] = lieuNais;
        request.fields["dateNais"] = dateNais;
        request.fields["etatcivile"] = etatcivile;
        request.fields["adresse"] = adresse;
        request.fields["commune"] = commune;
        request.fields["telephone"] = telephone;
        request.fields["nationalite"] = nationalite;
        request.fields["province"] = province;
        request.fields["territoire"] = territoire;
        request.fields["agent"] = agent;
        request.fields["residence"] = residence;
        request.fields["marchePro"] = marchePro;
        request.fields["article"] = article;
        request.fields["place"] = place;
        request.fields["categorie"] = categorie;

        request.headers["Authorization"] = "";
        var pic = await http.MultipartFile.fromPath("photo", photo.path);
        print("La photo après conversion multipart: ${pic}");
        request.files.add(pic);
        var rep = await request.send();
        print("+++++++++++++++ le retour de la requette envoie: ${rep}");
        print(rep.runtimeType);
        var reponseData = await rep.stream.toBytes();
        print(reponseData);
        var reslt = String.fromCharCodes(reponseData);
        print(reslt);
        print(" ******  response  ****** ");
        if (rep.statusCode == 200) {
          print(" ******  200  ****** ");
          print("*********** image uploader avec succès");
          _loading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Success()));

          //ici tu met la redirection en fonction de l'action qui vas suivre...
        } else {
          print(rep.statusCode);
          var msg =
              "-------- un Problème se pose dans les informations fournies";
          setState(() {
            _loading = false;
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

  void showSnackbar(String titre) {
    final snackbar = SnackBar(
      content: Text(
        titre,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  void toast(String msag) {
    Fluttertoast.showToast(
        msg: msag,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2);
  }
}
