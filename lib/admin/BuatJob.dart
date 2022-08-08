import 'package:alumni_fasilkom/admin/AdminJob.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BuatJob extends StatefulWidget {
  const BuatJob({Key? key}) : super(key: key);

  @override
  State<BuatJob> createState() => _BuatJobState();
}

class _BuatJobState extends State<BuatJob> {
  TextEditingController namaJobController = TextEditingController();
  TextEditingController descJobController = TextEditingController();
  TextEditingController dateCreatedController = TextEditingController();

  Future buatJob() async {
    addJobDetails(
      namaJobController.text.trim(),
      descJobController.text.trim(),
      dateCreatedController.text.trim(),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => AdminJob()));
  }

  Future addJobDetails(
    String namaJob,
    String descJob,
    String dateCreated,
  ) async {
    await FirebaseFirestore.instance.collection('job').add({
      'namaJob': namaJob,
      'descJob': descJob,
      'dateCreated': dateCreated,
    });
  }

  @override
  void dispose() {
    namaJobController.dispose();
    descJobController.dispose();
    dateCreatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Buat Job Baru'),
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
                      controller: namaJobController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nama Job',
                          hintText: 'Masukkan Nama Job'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: dateCreatedController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tanggal Dibuat',
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
                              DateFormat('MMMM dd, yyyy')
                                  .format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            dateCreatedController.text = formattedDate;
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
                      controller: descJobController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Deskripsi',
                          hintText: 'Masukkan Deskripsi Job'),
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
                          'Buat Job',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onPressed: () {
                          buatJob();
                        },
                      )),
                ],
              ))),
    );
  }
}
