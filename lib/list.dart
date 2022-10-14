import 'package:flutter/material.dart';
import 'package:yodex/database/databaselist.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yodex/detail_list.dart';
import 'package:yodex/model/pengeluaran.dart';

class listPage extends StatefulWidget {
  const listPage({Key? key}) : super(key: key);
  @override
  _listPage createState() => _listPage();
}

class _listPage extends State<listPage> {
  late List<pengeluaran> list;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshlist();
  }

  @override
  void dispose() {
    listdatabase.instance.close();
    super.dispose();
  }

  Future refreshlist() async {
    setState(() => isLoading = true);
    this.list = await listdatabase.instance.readAllpengeluaran();
    setState(() => isLoading = false);
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
              width: 354,
              height: 40,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(27)),
                  border: Border.all(color: Colors.grey, width: 0.5)),
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
          SizedBox(
            height: 530,
            child: isLoading
                ? CircularProgressIndicator()
                : list.isEmpty
                    ? Text(
                        'tidak ada pengeluaran',
                        style: TextStyle(color: Colors.grey, fontSize: 24),
                      )
                    : buildlist(),
          ),
        ],
      ),
    ));
  }

  Widget buildlist() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: list.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final catatan = list[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => listdetailpage(listId: catatan.id!),
              ));
              refreshlist();
            },
          );
        },
      );
}

void sortlist() {}
