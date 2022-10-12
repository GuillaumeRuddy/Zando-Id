import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zando_id/model/personne.dart';
import 'package:zando_id/ui/updateInformationPersonnelle.dart';
import 'package:zando_id/widgets/loading.dart';

class Actualite extends StatefulWidget {
  final String userName;
  final String idUser;

  //const Acceuil({Key? key, this.login}) : super(key: key);
  const Actualite({Key? key, required this.userName, required this.idUser})
      : super(key: key);

  @override
  _ActualiteState createState() => _ActualiteState();
}

class _ActualiteState extends State<Actualite> {
  bool _loading = false;
  List<Personne> listInfo = [];
  var utilisateur;

  // le snack
  void snackBar(String msg) {
    SnackBar snackBar =
        new SnackBar(content: Text(msg), duration: new Duration(seconds: 5));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // le toast
  void toast(String msag) {
    Fluttertoast.showToast(
        msg: msag,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2);
  }

  // debut traitement API pour la recuperation des informations
  Future info(String idAgent) async {
    // test de connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _loading = true;
      });
      try {
        final reponse = await http
            .post(
                Uri.parse(
                    "http://zando-app.e-entrepreneurdrc.com/zando_api/public/api/rejeter"),
                headers: <String, String>{
                  "Content-type": "application/json; chartset=UTF-8"
                },
                body: jsonEncode(<String, String>{"agent_id": idAgent}))
            .timeout(const Duration(seconds: 15), onTimeout: () {
          _loading = false;
          snackBar("Delais d'attente depasser, veuillez reessaie plus tard");
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        if (reponse.statusCode == 200) {
          var datas = json.decode(reponse.body);
          print("les datas que je recupère *********** " + datas.toString());
          var data = datas["personnes"];
          print("les data de la personne que je recupère ***********++++ " +
              data.toString());
          if (data != null) {
            /*var result = data["actualite du jour"];*/
            print("++++++++ je netoye ++++++++");
            listInfo.clear();
            for (var item in data) {
              print(item);
              Map<String, dynamic> it = {
                "id": item["id"].toString(),
                "nom": item["nom"].toString(),
                "postnom": item["postnom"].toString(),
                "prenom": item["prenom"].toString(),
                "sexe": item["sexe"].toString(),
                "lieu_naissance": item["lieu_naissance"].toString(),
                "date_naissance": item["date_naissance"].toString(),
                "etat_civil": item["etat_civil"].toString(),
                "telephone": item["telephone"].toString(),
                "residence": item["residence"].toString(),
                "nationalite": item["nationalite"].toString(),
                "province": item["province"].toString(),
                "territoire": item["territoire"].toString(),
                "photo": item["photo"].toString()
              };
              print("###### linstance ######");
              print(it);
              print("###### je convertie en personne ########");
              Personne rej = Personne.fromJson(it);
              print(rej.id);
              print(rej.nom);
              print("###### jajoute ########");
              listInfo.add(rej);
              print("###### fin jajoute ########");
            }
            setState(() {
              _loading = false;
            });
          } else {
            setState(() {
              _loading = false;
            });
          }
        } else {
          setState(() {
            _loading = false;
          });
          return null;
        }
      } on TimeoutException {
        setState(() {
          _loading = false;
          print("temps d'attente depassé");
          /*Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Acceuil()));*/
        });
      } on SocketException {
        setState(() {
          _loading = false;
          snackBar(
              "Nous rencontrons un problème, veuillez essaie ulterieuement");
        });
        /* Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Acceuil())); */
      } catch (e) {
        setState(() {
          _loading = false;
          snackBar(
              "Nous rencontrons un problème, veuillez essaie ulterieuement");
        });
      }
    } else {
      setState(() {
        _loading = false;
        Navigator.of(context).pop();
        //Navigator.of(context).pop(MaterialPageRoute(builder: (_) => Menu()));
        toast("Connexion impossible, vérifier vôtre connexion internet");
      });
    }
  }

  void _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    utilisateur = prefs.getString('user')!;
  }

  @override
  void initState() {
    super.initState();
    _getPreferences();
    info(widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("VENDEUR REJETER "),
              //backgroundColor: Colors.transparent,
              elevation: 3.0,
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      info(utilisateur);
                    })
              ],
            ),
            body: Stack(
              children: [
                /* Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/sup.png"),
                          fit: BoxFit.fitHeight)),
                ), */
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white, Colors.blue])),
                  ),
                ),
                ListView.builder(
                    itemCount: listInfo.length,
                    itemBuilder: (context, i) {
                      final post = listInfo[i];
                      if (post.nom == null || post.nom == "") {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Aucun vendeur rejeter",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            var route = MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UpdateInformationPersonnellePage(
                                      userName: utilisateur,
                                      nom: post.nom,
                                      postnom: post.postnom,
                                      prenom: post.prenom,
                                      sexe: post.sexe,
                                      lieuNais: post.lieu_naissance,
                                      dateNais: post.date_naissance,
                                      etatcivile: post.etatCiv,
                                      adresse: post.residence,
                                      telephone: post.telephone,
                                      nationalite: post.nationalite,
                                      province: post.province,
                                      territoire: post.territoire,
                                      agent: post.id,
                                      residence: post.residence,
                                    ));
                            Navigator.of(context).push(route);
                          },
                          child: Card(
                            elevation: 5.0,
                            margin: EdgeInsets.only(bottom: 3.0),
                            child: Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Row(
                                children: [
                                  //Icon(Icons.account_box_rounded),
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            //image: NetworkImage(post.photo),
                                            image:
                                                AssetImage("assets/visage.png"),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.nom.toUpperCase() +
                                            " - " +
                                            post.postnom.toUpperCase() +
                                            " - " +
                                            post.prenom.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800]),
                                      ),
                                      /*SizedBox(
                                      height: 10.0,
                                    ),
                                    Divider(height: 3, color: Colors.black),
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.,
                                          size: 15.0,
                                        ),
                                        SizedBox(
                                          width: 3.0,
                                        ),
                                        Text(
                                          post.date,
                                          style: TextStyle(fontSize: 11.0),
                                        )
                                      ],
                                    )*/
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    })
              ],
            ));
  }
}

//      String result = "{ \"Infractions\": [ [ \"01\", \"delit_fuite\", \"Sun, 11 Oct 2020 15:13:07 GMT\",
//      \"4319_8630\", \"Sun, 11 Oct 2020 15:13:07 GMT\" ], [ \"01\", \"violation_sans-unique\",
//      \"Sun, 11 Oct 2020 15:34:38 GMT\", \"6470_12940\", \"Sun, 11 Oct 2020 15:34:38 GMT\" ],
//      [ \"02\", \"violation_sans-unique\", \"Sun, 11 Oct 2020 15:36:57 GMT\", \"6470_12940\",
//      \"Sun, 11 Oct 2020 15:36:57 GMT\" ], [ \"03\", \"violation_sans-unique\",
//      \"Sun, 11 Oct 2020 15:37:07 GMT\", \"6470_12940\", \"Sun, 11 Oct 2020 15:37:07 GMT\" ] ] }";

/* String result = "{\"actualite du jour\": [[\"Premier titre\", \"Bienvenue sur notre application mobile\", \"capture\", \"Wed 02 Jun 2021 16:58:01 GMT\"],[\"Second titre\", \"Kidiaba aza mutu ya vita\", \"capture\", \"Wed 02 Jun 2021 17:01:23 GMT\"],[\"A la une ce matin au stade de martyr\", \"des jeunes on fait des troubles au stade, suite au ramadan\", \"citederefuge.png\", \"Thu, 03 Jun 2021 15:02:48 GMT\"],[\"Nouvel entraineur pour le vert et blanc de la capitale\", \"Le noubvelle entraineur des vert et blanc chaud bouillon suite au différente victoire gagner dans des clubs dans différent pays\", \"citederefuge.jpg\", \"Thu, 03 Jun 2021 15:06:50 GMT\"],[\"Les supporteur on en marre des dirrigeants du DCMP\",\" je ne sais pas qu'est ce qui se passe mais les dirigeants ne veulent plus satisfaire les clients dans les différents rencontres avec les clubs riveau et parrait-t-il qu'il ont bouffé l'argent adverse sans moderation\", \"ça photo.jpg\", \"Thu, 03 Jun 2021 15:31:55 GMT\"],[\"les supporter veut encore plus pour nous\", \"on vous en diras encore plus d'ici quelque jours alors rester connecter...\", \"çaphoto.jpg\",\" Thu, 03 Jun 2021 15:33:30 GMT\"]]}";
 */
