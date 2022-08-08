import 'package:alumni_fasilkom/admin/AdminDrawer.dart';
import 'package:alumni_fasilkom/admin/BuatEvent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AdminEvent extends StatefulWidget {
  @override
  _AdminEventState createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent> {
  int _selectedItem = 0;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Event'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BuatEvent()));
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('event')
              .orderBy('tglEvent', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                key: Key('selected $_selectedItem'),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  return ExpansionTile(
                    key: Key(index.toString()),
                    initiallyExpanded: index == _selectedItem,
                    title: Text(
                      doc['namaEvent'] +
                          '\n' +
                          doc['tglEvent'] +
                          '\n' +
                          doc['jamEvent'],
                      style: TextStyle(height: 1.5),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          doc['descEvent'],
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.justify,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  final collection = FirebaseFirestore.instance
                                      .collection('event');
                                  collection
                                      .doc(doc.id) // <-- Doc ID to be deleted.
                                      .delete(); // <-- Delete
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      )
                    ],
                    onExpansionChanged: (isOpen) {
                      if (isOpen) {
                        setState(() {
                          _selectedItem = index;
                        });
                      }
                    },
                  );
                },
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
              );
            } else {
              return const RefreshProgressIndicator();
            }
          }),
      drawer: AdminDrawer(),
    );
  }
}
