import 'package:flutter/material.dart';
import 'package:alumni_fasilkom/users/HomePage.dart';
import 'package:alumni_fasilkom/users/EventPage.dart';
import 'package:alumni_fasilkom/users/JobPage.dart';
import 'package:alumni_fasilkom/users/AboutPage.dart';
import 'package:alumni_fasilkom/users/ProfilePage.dart';
import 'package:alumni_fasilkom/users/SettingsPage.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer();

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder(
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
                    return ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(users1['nama']),
                          accountEmail: Text(users1['nim']),
                          currentAccountPicture: CircleAvatar(
                              child: ProfilePicture(
                            name: users1['nama'],
                            radius: 36,
                            fontsize: 25,
                          )),
                          otherAccountsPictures: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              )),
                              child: CircleAvatar(
                                child: Icon(Icons.account_circle),
                              ),
                            ),
                          ],
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 14, 96, 172),
                          ),
                        ),
                        ListTile(
                          title: const Text('Home'),
                          onTap: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage(),
                          )),
                        ),
                        ListTile(
                          title: const Text('Event'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EventPage(),
                            ));
                          },
                        ),
                        ListTile(
                          title: const Text('Job Opportunity'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JobPage(),
                            ));
                          },
                        ),
                        ListTile(
                          title: const Text('Settings'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SettingsPage(),
                            ));
                          },
                        ),
                        ListTile(
                          title: const Text('About'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AboutPage(),
                            ));
                          },
                        ),
                      ],
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
