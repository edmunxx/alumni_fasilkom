import 'package:alumni_fasilkom/admin/AdminEvent.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BuatEvent extends StatefulWidget {
  const BuatEvent({Key? key}) : super(key: key);

  @override
  State<BuatEvent> createState() => _BuatEventState();
}

class _BuatEventState extends State<BuatEvent> {
  TextEditingController namaEventController = TextEditingController();
  TextEditingController tglEventController = TextEditingController();
  TextEditingController jamEventController = TextEditingController();
  TextEditingController descEventController = TextEditingController();
  DateTime? _dateTime;

  Future buatEvent() async {
    addEventDetails(
      namaEventController.text.trim(),
      tglEventController.text.trim(),
      jamEventController.text.trim(),
      descEventController.text.trim(),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => AdminEvent()));
  }

  Future addEventDetails(
    String namaEvent,
    String tglEvent,
    String jamEvent,
    String descEvent,
  ) async {
    await FirebaseFirestore.instance.collection('event').add({
      'namaEvent': namaEvent,
      'tglEvent': tglEvent,
      'jamEvent': jamEvent,
      'descEvent': descEvent,
    });
  }

  @override
  void initState() {
    tglEventController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    namaEventController.dispose();
    tglEventController.dispose();
    jamEventController.dispose();
    descEventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Buat Event Baru'),
            backgroundColor: Color.fromARGB(255, 14, 96, 172),
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: namaEventController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nama Event',
                          hintText: 'Masukkan Nama Event'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: tglEventController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Hari, Tanggal Event',
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                              DateFormat('MMMM dd, yyyy').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            tglEventController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Tanggal tidak terpilih");
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: jamEventController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Jam Event',
                          hintText: 'Mis. 10:00-12:00'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: descEventController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Deskripsi',
                          hintText: 'Masukkan Deskripsi Event'),
                      minLines: 1,
                      maxLines: 100,
                    ),
                  ),
                  Container(
                      height: 70,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 14, 96, 172),
                        ),
                        child: const Text(
                          'Buat Event',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onPressed: () {
                          buatEvent();
                        },
                      )),
                ],
              ))),
    );
  }
}
