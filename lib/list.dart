import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yodex/database/databaselist.dart';
import 'package:yodex/model/pengeluaran.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:yodex/update_screen.dart';

class listPage extends StatefulWidget {
  const listPage({Key? key}) : super(key: key);

  @override
  _listPage createState() => _listPage();
}

class _listPage extends State<listPage> {
  DatabaseInstance? databaseInstance;
  DatabaseInstance database = DatabaseInstance();
  String userSearchInput = "";
  TextEditingController search = TextEditingController();
  List<TransaksiModel> list = <TransaksiModel>[];
  List<TransaksiModel> filteredList = <TransaksiModel>[];
  List<TransaksiModel> sortList = <TransaksiModel>[];
  bool doItJustOnce = false;
  final nama = TextEditingController();
  final harga = TextEditingController();
  TransaksiModel edit = TransaksiModel();
  String formattedDate =
      DateFormat('HH:mm E, d MMM yyyy').format(DateTime.now());
  int _value = 1;

  //void _filterList(String value) {
  //  setState(() {
  //    filteredList = list
  //        .where(
  //            (text) => text.name!.toLowerCase().contains(value.toLowerCase()))
  //        .toList();
  //  });
  //}

  void _sortListname(String value) {
    setState(() {
      list.sort((a, b) => a.name!.compareTo(b.name!));
    });
  }

  void _sortListwaktu(String value) {
    setState(() {
      list.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    });
  }

  void _sortListpengeluaran(String value) {
    setState(() {
      list.sort((a, b) => b.total!.compareTo(a.total!));
    });
  }

  //bool isLoading = false;
  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    _refresh();

    setState(() {});
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
  String dropdownvalue = 'Waktu';
  String keyword = "";
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
              child: TextField(
                onChanged: (value) {
                  keyword = value;
                  setState(() {});
                },
                controller: search,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search_rounded,
                      color: Color.fromRGBO(45, 12, 87, 1),
                    ),
                    suffixIcon: IconButton(
                      onPressed: search.clear,
                      icon: Icon(Icons.clear),
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
                    if (dropdownvalue == 'Waktu') {
                      _sortListwaktu(dropdownvalue);
                    }
                    if (dropdownvalue == 'Nama') {
                      _sortListname(dropdownvalue);
                    }
                    if (dropdownvalue == 'Pengeluaran') {
                      _sortListpengeluaran(dropdownvalue);
                    }
                  });
                },
              ),
            ),
          ),
          FutureBuilder<List<TransaksiModel>>(
              future: databaseInstance!.search(keyword),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TransaksiModel>> snapshot) {
                print('HASIL : ' + snapshot.data.toString());
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else {
                  if (snapshot.hasData) {
                    if (!doItJustOnce) {
                      //    //You should define a bool like (bool doItJustOnce = false;) on your state.
                      list = snapshot.data!;
                      // filteredList = list;
                      doItJustOnce = !doItJustOnce;
//
                      // setState(() {});
                      //    //this line helps to do just once.
                    }
                    return SizedBox(
                      height: 450,
                      child: Expanded(
                          child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
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
                                    Text(list[index].createdAt!),
                                    IconButton(
                                        onPressed: () {
                                          showAlertDialog(
                                              context, list[index].id!);
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.red))
                                  ],
                                ),
                                title: Text(list[index].name!),
                                subtitle: Text(list[index].total!.toString()),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => UpdateScreen(
                                                transaksiMmodel: list[index],
                                              )))
                                      .then((value) {
                                    setState(() {});
                                  });
                                }),
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
