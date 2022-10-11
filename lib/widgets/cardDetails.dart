import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CardDetails(String titre, String img) {
  return Material(
    elevation: 4.0,
    borderRadius: BorderRadius.circular(7.0),
    child: Container(
      height: 120.0,
      width: 280.0,
      // width: (MediaQuery.of(context).size.width / 2) - 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /* SizedBox(
            height: 10.0,
          ), */
          Padding(
            padding: EdgeInsets.all(15.0),
            //padding: EdgeInsets.only(left: 15.0),
            child: Image.asset(
              img,
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              height: 50.0,
              width: 50.0,
            ),
          ),
          SizedBox(height: 2.0),
          Padding(
            padding: EdgeInsets.all(5.0),
            //padding: EdgeInsets.only(left: 15.0),
            child: Text(
              titre,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}
