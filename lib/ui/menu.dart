import 'package:flutter/material.dart';
import 'package:zando_id/ui/drawer.dart';
import 'package:zando_id/ui/informationPersonnelle.dart';
import 'package:zando_id/ui/rejet.dart';
import 'package:zando_id/widgets/cardDetails.dart';

class Acceuil extends StatefulWidget {
  //final VoidCallback login;
  final String userName;
  final String idUser;

  //const Acceuil({Key? key, this.login}) : super(key: key);
  const Acceuil({Key? key, required this.userName, required this.idUser})
      : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    //UserModel.getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size taille = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(
          child: DrawerAdd(),
        ),
        body: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                  height: taille.height,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        // margin: EdgeInsets.only(top: taille.height * 0.3),
                        height: taille.height / 2.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            //color: Colors.green,
                            image: DecorationImage(
                                image: AssetImage("assets/hv.png"),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60.0),
                              bottomRight: Radius.circular(60.0),
                            )),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          /*Container(
                        margin: EdgeInsets.all(10.0),
                        alignment: Alignment.topLeft,
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(300.0),
                            border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2.0),
                            image: DecorationImage(
                                image: AssetImage("assets/imana.png"))),
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Text(
                            'DCMP',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Club ya bana mboka',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),*/
                          /*SizedBox(
                          width: MediaQuery.of(context).size.width - 230.0),
                      Container(
                        //margin: EdgeInsets.only(left: 5.0),
                        alignment: Alignment.topRight,
                        child: PopupMenuButton<MenuItem>(
                          color: Colors.white,
                          onSelected: (item) => onSelected(context, item),
                          itemBuilder: (context) => [
                            ...MenuItems.list1.map(lesItems).toList(),
                            PopupMenuDivider(),
                            ...MenuItems.list2.map(lesItems).toList(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0)
                    ],
                  ),*/
                          /*Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 60.0, horizontal: 110.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /*Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),*/
                                ],
                              )),*/
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: taille.height / 3.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            /* MaterialPageRoute(builder: (_) => Info())); */
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    InformationPersonnellePage(
                                                        userName:
                                                            widget.userName)));
                                      },
                                      child: CardDetails(
                                          'Enregistrement', 'assets/hv.png')),
                                  /*InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Cotisation()));
                              },
                              child:
                                  CardDetails('Cotisation', 'assets/paye.png')),*/
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => Actualite(
                                                    userName: widget.userName,
                                                    idUser: widget.idUser)));
                                      },
                                      child: CardDetails(
                                          'Rejeter', 'assets/hv.png')),
                                  /*InkWell(
                              onTap: () {
                                //UserModel.getUser();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => Equipe()));
                              },
                              child: CardDetails('Equipe', 'assets/imana.png')),*/
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          )
        ]));
  }
}
