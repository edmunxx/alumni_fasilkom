import 'package:alumni_fasilkom/users/DaftarPage.dart';
import 'package:alumni_fasilkom/users/HomePage.dart';
import 'package:alumni_fasilkom/users/auth/UserAuthPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:alumni_fasilkom/users/HomePage.dart';
import 'package:alumni_fasilkom/users/LoginPage.dart';

class UserMainPage extends StatelessWidget {
  const UserMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const UserAuthPage();
          }
        },
      ),
    );
  }
}
