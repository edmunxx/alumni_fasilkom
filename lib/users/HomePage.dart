import 'package:alumni_fasilkom/users/MenuDrawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
      ),
      body: Center(
        child: Text(
            "\t\t\t\t\t\t\t\t\t\t\t\tSelamat Datang di Aplikasi \nMobile Alumni Fakultas Ilmu Komputer",
            style: TextStyle(fontSize: 16)),
      ),
      drawer: MenuDrawer(),
    );
  }
}
