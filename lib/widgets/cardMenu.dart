import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CardMenu(String nom, String imageUp) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 7.0,
    child: Column(
      children: [
        SizedBox(height: 12.0),
        Container(
          height: 90.0,
          width: 90.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              image: DecorationImage(image: AssetImage(imageUp))),
        ),
        SizedBox(height: 5.0),
        /*Text(
          nom,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800]),
        ),
        SizedBox(height: 5.0),*/
        Expanded(
            child: Container(
          //width: 140.0,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Center(
            child: Text(
              nom,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ))
      ],
    ),
    //margin: EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0),
  );
}
