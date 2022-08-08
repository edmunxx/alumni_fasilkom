import 'package:alumni_fasilkom/admin/AdminDrawer.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Home'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
      ),
      body: Center(
        child: Text(
            "\t\t\t\t\t\t\t\t\t\t\t\tSelamat Datang di Aplikasi \nMobile Alumni Fakultas Ilmu Komputer",
            style: TextStyle(fontSize: 16)),
      ),
      drawer: AdminDrawer(),
    );
  }
}
