import 'package:alumni_fasilkom/users/MenuDrawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Job Opportunity'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
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
      drawer: MenuDrawer(),
    );
  }
}
