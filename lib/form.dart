import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void form(context) {
  Alert(
    context: context,
    title: "Pengeluaran baru",
    content: Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            icon: Icon(
              Icons.move_to_inbox_rounded,
              color: Color.fromARGB(156, 87, 13, 184),
            ),
            labelText: 'Nama',
          ),
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Text(
              ' Rp',
              style: TextStyle(
                  color: Color.fromARGB(156, 87, 13, 184), fontSize: 15),
            ),
            labelText: 'Harga',
          ),
        ),
      ],
    ),
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(50, 168, 82, 10),
        child: const Text(
          "SIMPAN",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  ).show();
}
