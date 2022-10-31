import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:yodex/database/databaselist.dart';
import 'package:yodex/list.dart';
import 'package:yodex/model/pengeluaran.dart';

class UpdateScreen extends StatefulWidget {
  final TransaksiModel transaksiMmodel;
  const UpdateScreen({Key? key, required this.transaksiMmodel})
      : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    nameController.text = widget.transaksiMmodel.name!;
    totalController.text = widget.transaksiMmodel.total!.toString();
    _value = widget.transaksiMmodel.type!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 65),
                child: Text(
                  'Update Pengeluaran',
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
              SizedBox(
                height: 40,
              ),
              Text("Nama"),
              TextField(
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Harga"),
              TextField(
                controller: totalController,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(top: 200),
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 340,
                  height: 56,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(50, 168, 82, 10),
                          elevation: 3,
                          padding: EdgeInsets.only(top: 4)),
                      onPressed: () async {
                        await databaseInstance
                            .update(widget.transaksiMmodel.id!, {
                          'name': nameController.text,
                          'type': _value,
                          'total': totalController.text,
                          'updated_at': DateTime.now().toString()
                        });
                        Navigator.pop(context);
                        setState(() {
                          
                        });
                      },
                      child: Text("SIMPAN", style: TextStyle(fontSize: 20))),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 340,
                  height: 56,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'kembali',
                        style: TextStyle(
                            color: Color.fromARGB(255, 131, 131, 131)),
                      )),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
