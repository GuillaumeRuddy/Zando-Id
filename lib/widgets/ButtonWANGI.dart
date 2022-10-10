import 'package:flutter/material.dart';

class ButtonWANGI extends StatelessWidget {
  String titre;
  Color color;
  VoidCallback onPressed;

  ButtonWANGI({
    this.titre = "",
    this.color = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        primary: color,
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 4,
          right: MediaQuery.of(context).size.width / 4,
          top: MediaQuery.of(context).size.width / 20,
          bottom: MediaQuery.of(context).size.width / 20,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        titre,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
