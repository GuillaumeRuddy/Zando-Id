import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zando_id/ui/login.dart';
import 'package:zando_id/ui/rejet.dart';

class DrawerAdd extends StatelessWidget {
  const DrawerAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 60.0, backgroundImage: AssetImage('assets/hv.png')),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "ZANDO ID",
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 202, 126, 5)),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Enregistrement des vendeurs de Zando",
                style: TextStyle(fontSize: 13.0, color: Colors.blue[900]),
              ),
              //Divider(height: 3, color: Colors.black),
            ],
          ),
        )),
        SizedBox(
          height: 5.0,
        ),
        /* Divider(
          color: Colors.black,
          height: 1.0,
        ), */
        Divider(height: 1.0, color: Colors.black),
        SizedBox(
          height: 5.0,
        ),
        ListTile(
          onTap: () {
            /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Actualite())); */
          },
          leading: Icon(
            Icons.book,
            color: Colors.blue,
          ),
          title: Text("Liste de rejet"),
        ),
        Divider(height: 1.0, color: Colors.black),
        ListTile(
          onTap: null,
          leading: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
          title: Text("parametre"),
        ),
        Divider(height: 1.0, color: Colors.black),
        ListTile(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          leading: Icon(
            FontAwesomeIcons.signOutAlt,
            color: Colors.blue,
          ),
          title: Text("Deconnecter"),
        ),
        Divider(height: 1.0, color: Colors.black),
        ListTile(
          onTap: null,
          leading: Icon(
            Icons.info,
            color: Colors.blue,
          ),
          title: Text("A propos de nous"),
        ),
      ],
    );
  }
}
