import 'package:flutter/material.dart';
import 'package:yodex/database/databaselist.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yodex/detail_list.dart';
import 'package:yodex/model/pengeluaran.dart';
import 'package:yodex/main.dart';

class listPage extends StatefulWidget {
  const listPage({Key? key}) : super(key: key);
  @override
  _listPage createState() => _listPage();
}

class _listPage extends State<listPage> {
  DatabaseInstance? databaseInstance;
  //bool isLoading = false;
  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  showAlertDialog(BuildContext contex, int idTransaksi) {
    Widget okButton = TextButton(
      child: Text(
        "Yakin",
        style: TextStyle(color: Color.fromARGB(156, 87, 13, 184)),
      ),
      onPressed: () {
        //delete disini
        databaseInstance!.hapus(idTransaksi);
        Navigator.of(contex, rootNavigator: true).pop();
        setState(() {});
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Peringatan !"),
      content: Text("Anda yakin akan menghapus ?"),
      actions: [okButton],
    );

    showDialog(
        context: contex,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  //final pengeluaran = List<String>.generate(20, (i) => 'pengeluaran $i');
  var sortbutton = ['Nama', 'Waktu', 'Pengeluaran'];
  String dropdownvalue = 'Nama';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 65),
            child: Text(
              'List Pengeluaran',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(45, 12, 87, 1),
                  fontFamily: 'Roboto',
                  fontSize: 34,
                  letterSpacing: 0.4099999964237213,
                  fontWeight: FontWeight.bold,
                  height: 1.2058823529411764),
            ),
          ),
          SizedBox(height: 30),
          Container(
              alignment: AlignmentDirectional.centerEnd,
              //width: 354,
              //height: 40,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(27)),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: const TextField(
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Color.fromRGBO(45, 12, 87, 1),
                    ),
                    hintText: ('search'),
                    border: InputBorder.none),
              )),
          Container(
            alignment: AlignmentDirectional.centerEnd,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                // Initial Value
                value: dropdownvalue,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: sortbutton.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
          ),
          FutureBuilder<List<TransaksiModel>>(
              future: databaseInstance!.getAll(),
              builder: (context, snapshot) {
                print('HASIL : ' + snapshot.data.toString());
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 450,
                      child: Expanded(
                          child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide()),
                                color: Color.fromARGB(255, 221, 221, 221)),
                            child: ListTile(
                              leading: Icon(
                                Icons.move_to_inbox_rounded,
                                color: Color.fromARGB(156, 87, 13, 184),
                              ),
                              trailing: Wrap(
                                children: [
                                  Text(snapshot.data![index].createdAt!),
                                  IconButton(
                                      onPressed: () {
                                        showAlertDialog(
                                            context, snapshot.data![index].id!);
                                      },
                                      icon:
                                          Icon(Icons.delete, color: Colors.red))
                                ],
                              ),
                              title: Text(snapshot.data![index].name!),
                              subtitle:
                                  Text(snapshot.data![index].total!.toString()),
                            ),
                          );
                        },
                      )),
                    );
                  } else {
                    return Text("Tidak ada data");
                  }
                }
              })
        ],
      ),
    ));
  }
}

void sortlist() {}
