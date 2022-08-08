import 'package:alumni_fasilkom/users/MenuDrawer.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where("email", isEqualTo: auth.currentUser!.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    var users1 = snapshot.data!.docs[i];
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: 50,
                                      child: ProfilePicture(
                                        name: users1['nama'],
                                        radius: 50,
                                        fontsize: 40,
                                      )),
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nama Lengkap',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: TextField(
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: users1['nama'],
                              hintStyle: TextStyle(color: Colors.black),
                              enabled: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nomor Induk Mahasiswa (NIM)',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: TextField(
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: users1['nim'],
                              hintStyle: TextStyle(color: Colors.black),
                              enabled: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Alamat Email',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: TextField(
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: users1['email'],
                              hintStyle: TextStyle(color: Colors.black),
                              enabled: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tempat, Tanggal Lahir',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: TextField(
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: users1['tmpttgllahir'],
                              hintStyle: TextStyle(color: Colors.black),
                              enabled: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nomor Telepon',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: TextField(
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: users1['telpon'],
                              hintStyle: TextStyle(color: Colors.black),
                              enabled: false,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tahun Angkatan',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: TextField(
                            decoration: InputDecoration(
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: users1['thnAngkatan'],
                              hintStyle: TextStyle(color: Colors.black),
                              enabled: false,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(40),
                        )
                      ]),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
      drawer: MenuDrawer(),
    );
  }
}
