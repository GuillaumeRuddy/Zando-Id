import 'package:flutter/material.dart';

class TextFieldCustom {
  final String title;
  final String placeHolder;
  final bool ispass;
  String msg;
  String valuer;

  TextFieldCustom(
      {this.title = "",
      this.placeHolder = "",
      this.ispass = false,
      this.valuer = "",
      this.msg = "Veuillez spécifier ce champ!"});

  TextFormField textFormField() {
    return TextFormField(
      onChanged: (e) {
        valuer = e;
      },
      validator: (e) => e!.isEmpty ? this.msg : null,
      decoration: InputDecoration(
          hintText: this.placeHolder,
          labelText: this.title,
          labelStyle: TextStyle(color: Colors.green),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(1))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent))),
    );
  }

  String get value {
    return valuer;
  }
}
