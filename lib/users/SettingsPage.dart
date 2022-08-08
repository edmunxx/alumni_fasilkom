import 'package:alumni_fasilkom/WelcomePage.dart';
import 'package:alumni_fasilkom/users/MenuDrawer.dart';
import 'package:alumni_fasilkom/users/auth/UserAuthPage.dart';
import 'package:alumni_fasilkom/users/auth/UserMainPage.dart';
// ignore: depend_on_referenced_packages
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:alumni_fasilkom/users/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  userSignOut() async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => WelcomePage()),
        ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
        backgroundColor: Color.fromARGB(255, 14, 96, 172),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Bahasa'),
                value: Text('Indonesia'),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onPressed: (BuildContext context) {
                  userSignOut();
                },
              ),
            ],
          ),
        ],
      ),
      drawer: MenuDrawer(),
    );
  }
}
