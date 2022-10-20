import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zando_id/ui/home.dart';
import 'package:zando_id/ui/informationPersonnelle.dart';
import 'package:zando_id/ui/menu.dart';
import 'package:zando_id/widgets/loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String counterText = '0';
  bool valid = false;
  bool validPassword = false;
  bool showPassword = true;
  String mdp = "";
  String user = "";
  var idUser;

  GlobalKey<ScaffoldState> key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Center(
            child: Scaffold(
              key: key,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.red.shade200,
                          backgroundImage: AssetImage("assets/hv.png"),
                          /* child: Icon(CupertinoIcons.person_alt_circle,
                      color: Colors.red,
                      size: 60,),*/
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              "ZANDO ID",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text("Login.",
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[800],
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ))),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                autofocus: true,
                                controller: userController,
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.bottom,
                                //maxLength: 9,
                                onChanged: (value) {
                                  setState(() {
                                    counterText = value.length.toString();
                                  });

                                  if (value.length > 3) {
                                    setState(() {
                                      valid = true;
                                    });
                                  } else {
                                    valid = false;
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        bottom: 10, top: 22, left: 10),
                                    //counterText: '$counterText/09',
                                    counterStyle: TextStyle(fontSize: 10),
                                    labelText: 'Utilisateur',
                                    hintText: 'Entrez le nom d\'utilisateur',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1)),
                                    hintStyle: TextStyle(
                                        fontSize: 10, color: Colors.grey)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        TextField(
                          autofocus: true,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          textAlignVertical: TextAlignVertical.bottom,
                          obscureText: showPassword,
                          //maxLength: 20,
                          onChanged: (value) {
                            setState(() {
                              counterText = value.length.toString();
                            });

                            if (value.length > 3) {
                              setState(() {
                                validPassword = true;
                              });
                            } else {
                              validPassword = false;
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  bottom: 10, top: 22, left: 10),
                              // counterText: '$counterText/09',
                              counterStyle: TextStyle(fontSize: 10),
                              labelText: 'Mot de passe',
                              hintText: 'Tapez votre mot de passe',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: this.showPassword
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1)),
                              hintStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  //ce bouton fonctionne uniquement si le numero est valid
                  child: AbsorbPointer(
                    absorbing: valid == true ? false : true,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //Prend la couleur bleu si numero valid sinon grise
                        primary: valid == true && validPassword == true
                            ? Colors.green[700]
                            : Colors.grey,
                      ),
                      onPressed: () {
                        mdp = passwordController.text;
                        user = userController.text;

                        loger(user, mdp);

                        /*Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                      userName: user,
                                      idUser: "1",
                                    )));*/

                        /*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationPersonnellePage())); */
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Se Connecter",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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

  void snackBar(String msg) {
    SnackBar snackBar = new SnackBar(
        content: Text(msg),
        duration: new Duration(seconds: 5),
        backgroundColor: Color.fromARGB(255, 219, 25, 11),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
            label: 'OK',
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future loger(String login, String pass) async {
    print("mon user ************ " + login);
    print("mon mot de passe ************ " + pass);
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
                    "http://parentseleves-rdc.org/zando/public/api/loginapi"),
                headers: <String, String>{
                  "Content-type": "application/json; chartset=UTF-8"
                },
                body: jsonEncode(
                    <String, String>{"username": login, "password": pass}))
            .timeout(const Duration(seconds: 20), onTimeout: () {
          //<----Gestion du time out dans le cas ou sa prend trop de temps
          print(" ******  tozo zela  ****** ");
          snackBar("Delais d'attente depasser, veuillez reessaie plus tard");
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
            print(data["donnees"]["id"]);
            idUser = data["donnees"]["id"];

            // enregistrement des élements de l'utilisateur comme valeur de session qui sera repris dans les différents écrans
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString("user", login);
            pref.setString("id_user", idUser.toString());
            pref.setString("mdp", pass);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home(userName: login, idUser: idUser.toString())));

            /*Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Acceuil(userName: login, idUser: idUser.toString())));*/

            setState(() {
              toast("Connecter");
              bool _loading = false;
            });
          } else {
            var msg = "Le nom utilisateur ou mot de passe est incorrecte";
            setState(() {
              snackBar(msg);
            });
          }

          //ici tu met la redirection en fonction de l'action qui vas suivre...
        } else {
          print("la reponse du status est éééééééééé ");
          print(response.statusCode);
          setState(() {
            bool _loading = false;
            var msg = "vérification impossible";
            snackBar(msg);
          });
        }
      } on SocketException {
        setState(() {
          snackBar(
              "Nous rencontrons un problème, veuillez réessaie ulterieuement");
        });
      } on TimeoutException {
        setState(() {
          snackBar("Delais d'attente dépasser");
        });
      } catch (e) {
        print("erreur: $e");
        setState(() {
          snackBar("Nous rencontrons un problème $e");
        });
      }
    } else {
      setState(() {
        toast("Impossible de se connecter à internet");
      });
    }
  }

  //Sauvegarde dans le préférence
  void saveInfosPersonnel() async {
    print('Inside savepref');
    //_password = _passcontroller.text;
    user = userController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  } //fin savepref

}
