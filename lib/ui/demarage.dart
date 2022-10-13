// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zando_id/ui/login.dart';
import 'package:google_fonts/google_fonts.dart';

class Demarage extends StatelessWidget {
  int timing = 0;

  Demarage({Key? key, required this.timing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: timing), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 4,
                child: Image(image: AssetImage('assets/hv.png'))),
            Text(
              'Zando ID',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Version 1.0',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 30.0),
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
