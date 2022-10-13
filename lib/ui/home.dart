import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zando_id/ui/drawer.dart';
import 'package:zando_id/ui/informationPersonnelle.dart';
import 'package:zando_id/ui/rejet.dart';
import 'package:zando_id/widgets/cardDetails.dart';
import 'package:zando_id/widgets/cardMenu.dart';

class Home extends StatefulWidget {
  final String userName;
  final String idUser;

  const Home({Key? key, required this.userName, required this.idUser})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 247, 244, 244),*/
      appBar: AppBar(
        title: Text("Zando Id"),
      ),
      drawer: Drawer(
        child: DrawerAdd(),
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
                      fontWeight: FontWeight.w800,
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
                            "VENDEUR INCOMPLET",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 5.0),
                    Container(
                      height: 40.0,
                      width: 50.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "10",
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
          SizedBox(height: 40.0),
          Container(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Menu ",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
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
            'Utilisateur : ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            widget.userName.toUpperCase(),
            style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 197, 21, 8),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ]),
      ),
    );
  }
}
