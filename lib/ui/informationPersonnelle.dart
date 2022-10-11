import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zando_id/ui/activite.dart';
import 'package:zando_id/widgets/ButtonWANGI.dart';

//import 'package:image/image.dart' as ImageProcess;

class InformationPersonnellePage extends StatefulWidget {
  final String userName;
  //InformationPersonnellePage({Key? key}) : super(key: key);
  InformationPersonnellePage({Key? key, required this.userName})
      : super(key: key);

  @override
  _InformationPersonnellePageState createState() =>
      _InformationPersonnellePageState();
}

class _InformationPersonnellePageState
    extends State<InformationPersonnellePage> {
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

  //GlobalKey<ScaffoldState> cle = GlobalKey();

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

  Future _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    utilisateur = prefs.getString("user").toString();
    print('Ce que je vient de recuperer comme user :  ##### ' + utilisateur);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    etatCiv();
    return Scaffold(
      appBar: AppBar(
        title: Text("Identité personnelle"),
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
                        : widget.userName,
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
                    hintText: 'Postnom',
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
                    hintText: 'Prenom',
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
              // Bouton de validation
              ButtonWANGI(
                titre: 'SUIVANT',
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
    } else {
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
