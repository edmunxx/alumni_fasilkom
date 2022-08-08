import 'package:alumni_fasilkom/WelcomePage.dart';
import 'package:alumni_fasilkom/admin/AdminDrawer.dart';
import 'package:alumni_fasilkom/admin/auth/AdminAuthPage.dart';
import 'package:alumni_fasilkom/users/auth/UserAuthPage.dart';
// ignore: depend_on_referenced_packages
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:alumni_fasilkom/users/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminSettings extends StatefulWidget {
  @override
  _AdminSettingsState createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  FirebaseAuth auth = FirebaseAuth.instance;
  adminSignOut() async {
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
        title: Text('Admin Settings'),
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
                  adminSignOut();
                },
              ),
            ],
          ),
        ],
      ),
      drawer: AdminDrawer(),
    );
  }
}
