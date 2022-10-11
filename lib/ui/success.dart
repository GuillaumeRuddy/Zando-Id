import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zando_id/ui/informationPersonnelle.dart';
import 'package:zando_id/ui/menu.dart';
import 'package:zando_id/widgets/ButtonWANGI.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  var utilisateur;

  void _getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    utilisateur = prefs.getString('user')!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 236, 236),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/success.gif'),
              height: 250.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Vendeur enregistrer avec succès",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonWANGI(
              titre: 'Continuer',
              color: Colors.red,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InformationPersonnellePage(userName: utilisateur)));
              },
            ),
            SizedBox(
              height: 15,
            ),
            ButtonWANGI(
              titre: 'Aller au menu',
              color: Colors.green,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Acceuil(userName: utilisateur)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
