import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yodex/database/databaselist.dart';
import 'package:yodex/model/pengeluaran.dart';

class listdetailpage extends StatefulWidget {
  final int listId;
  const listdetailpage({
    Key? key,
    required this.listId,
  }) : super(key: key);

  @override
  State<listdetailpage> createState() => _listdetailpageState();
}

class _listdetailpageState extends State<listdetailpage> {
  late TransaksiModel list;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshlist();
  }

  Future refreshlist() async {
    setState(() => isLoading = true);
    setState(() {});
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      list.name.toString(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      list.total.toString(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(list.createdAt as DateTime),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
      );
}
