import 'package:alumni_fasilkom/admin/AdminDrawer.dart';
import 'package:flutter/material.dart';

class AdminAbout extends StatefulWidget {
  @override
  _AdminAboutState createState() => _AdminAboutState();
}

class _AdminAboutState extends State<AdminAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin About'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
      ),
      body: Center(
        child: Text(
            "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAplikasi Mobile Alumni\n\t\t\t\t\t\t\t\t\t\t\t\t\t\tFakultas Ilmu Komputer\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAnggota Kelompok:\n- Edmundo Ferdinandus (20190801001)\n- Joseph Febrian (20200801208)\n- Febsa Maulana Aziz (20200801210)",
            style: TextStyle(fontSize: 16)),
      ),
      drawer: AdminDrawer(),
    );
  }
}
