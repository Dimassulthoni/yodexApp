import 'package:flutter/material.dart';

class listpage extends StatefulWidget {
  const listpage({Key? key}) : super(key: key);
  @override
  _listpage createState() => _listpage();
}

class _listpage extends State<listpage> {
  final pengeluaran = List<String>.generate(20, (i) => 'pengeluaran $i');
  var sort = ['Nama', 'Waktu', 'Pengeluaran'];
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
                items: sort.map((String items) {
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
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: pengeluaran.length,

                // display each item of the product list
                itemBuilder: (context, index) {
                  return Card(
                    // In many cases, the key isn't mandatory
                    key: ValueKey(pengeluaran[index]),
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(pengeluaran[index])),
                  );
                }),
          )
        ],
      ),
    ));
  }
}
