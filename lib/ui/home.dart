import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zando_id/ui/drawer.dart';
import 'package:zando_id/ui/informationPersonnelle.dart';
import 'package:zando_id/ui/rejet.dart';
import 'package:zando_id/widgets/cardDetails.dart';
import 'package:zando_id/widgets/cardMenu.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final String userName;
  final String idUser;

  const Home({Key? key, required this.userName, required this.idUser})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _loading = false;
  var nbrRejet = 0;

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
                body: jsonEncode(<String, String>{"agent_id": widget.idUser}))
            .timeout(const Duration(seconds: 30), onTimeout: () {
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
            print("++++++++ je calcule ++++++++");
            for (var item in data) {
              print(item);
              nbrRejet = nbrRejet + 1;
              print("les rejetes sont: ùùùùùùùùùùùù $nbrRejet");
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    info(widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 247, 244, 244),*/
      appBar: AppBar(
        title: Text("Zando Id"),
      ),
      drawer: Drawer(
        child: DrawerAdd(userName: widget.userName, idUser: widget.idUser),
      ),
      body: Column(
        //shrinkWrap: true,
        children: [
          Stack(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 100,
                  color: Colors.white,
                  child: Text(
                    "TABLEAU DE BORD",
                    style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 201, 19, 6),
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(40.0, 80.0, 40.0, 0.0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 49, 146, 226),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2.0,
                          color: Color.fromARGB(255, 95, 177, 209))
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        /*Container(
                            padding: EdgeInsets.fromLTRB(25.0, 25.0, 5.0, 5.0),
                            child: Text(
                              "Vendeur rejeter",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0),
                            ),
                          ),*/
                        Container(
                          padding: EdgeInsets.all(25.0),
                          child: Text(
                            "VENDEUR INVALIDE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 35.0),
                    Container(
                      height: 40.0,
                      width: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        nbrRejet.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 50.0),
          Container(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Menu ",
                  style: GoogleFonts.lato(
                    color: Color.fromARGB(255, 201, 19, 6),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  Text(
                    'Connecter : ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.userName.toUpperCase(),
                    style: GoogleFonts.lato(
                      color: Color.fromARGB(255, 6, 153, 11),
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ]),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(20.0),
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            shrinkWrap: true,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        /* MaterialPageRoute(builder: (_) => Info())); */
                        MaterialPageRoute(
                            builder: (_) => InformationPersonnellePage(
                                userName: widget.userName)));
                  },
                  child: CardMenu("ENREGISTRER", "assets/enr.png")),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Actualite(
                            userName: widget.userName, idUser: widget.idUser)));
                  },
                  child: CardMenu("REJETER", "assets/rejet.gif")),
            ],
          )
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 10.0),
        color: Colors.white,
        child: Row(children: [
          Text(
            'Powered by ',
            style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 201, 19, 6),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'PROFONDEUR AGENCY',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Container(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 15,
              child: Image.asset('assets/pa.jpg'))
        ]),
      ),
    );
  }
}
