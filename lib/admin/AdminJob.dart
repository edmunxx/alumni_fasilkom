import 'package:alumni_fasilkom/admin/AdminDrawer.dart';
import 'package:alumni_fasilkom/admin/BuatJob.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminJob extends StatefulWidget {
  @override
  _AdminJobState createState() => _AdminJobState();
}

class _AdminJobState extends State<AdminJob> {
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin Job Opportunity'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BuatJob()));
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('job')
              .orderBy('dateCreated', descending: true)
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
                      doc['namaJob'] + '\n' + doc['dateCreated'],
                      style: TextStyle(height: 1.5),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          doc['descJob'],
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.justify,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  final collection = FirebaseFirestore.instance
                                      .collection('job');
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
