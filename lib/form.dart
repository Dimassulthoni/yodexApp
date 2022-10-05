import 'package:flutter/material.dart';

void form(context) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    "Tambah pengeluaran",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Nama Lengkap",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              style: new TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: new InputDecoration(
                hintText: "Input nama lengkap",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 15.0),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Kontak",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              style: new TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: new InputDecoration(
                hintText: "Input kontak",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 15.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: MaterialButton(
              color: Colors.blue,
              child: const Text(
                "SIMPAN",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      );
    },
  );
}
