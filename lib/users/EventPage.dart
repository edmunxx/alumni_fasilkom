import 'package:alumni_fasilkom/users/MenuDrawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Event'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
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
