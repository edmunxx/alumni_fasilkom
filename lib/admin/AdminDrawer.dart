import 'package:alumni_fasilkom/admin/AdminAbout.dart';
import 'package:alumni_fasilkom/admin/AdminEvent.dart';
import 'package:alumni_fasilkom/admin/AdminHome.dart';
import 'package:alumni_fasilkom/admin/AdminJob.dart';
import 'package:alumni_fasilkom/admin/AdminSettings.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer();

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("admin")
              .where("email", isEqualTo: auth.currentUser!.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    var admin1 = snapshot.data!.docs[i];
                    return ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(admin1['nama']),
                          accountEmail: Text(admin1['email']),
                          currentAccountPicture: CircleAvatar(
                              child: ProfilePicture(
                            name: admin1['nama'],
                            radius: 36,
                            fontsize: 25,
                          )),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 14, 96, 172),
                          ),
                        ),
                        ListTile(
                          title: const Text('Home'),
                          onTap: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => AdminHome(),
                          )),
                        ),
                        ListTile(
                          title: const Text('Event'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminEvent(),
                            ));
                          },
                        ),
                        ListTile(
                          title: const Text('Job Opportunity'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminJob(),
                            ));
                          },
                        ),
                        ListTile(
                          title: const Text('Settings'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminSettings(),
                            ));
                          },
                        ),
                        ListTile(
                          title: const Text('About'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminAbout(),
                            ));
                          },
                        ),
                      ],
                    );
                  });
            }
            return ListView();
          }),
    );
  }
}
