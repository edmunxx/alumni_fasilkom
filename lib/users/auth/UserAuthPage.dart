import 'package:alumni_fasilkom/users/LoginPage.dart';
import 'package:alumni_fasilkom/users/DaftarPage.dart';
import 'package:flutter/material.dart';

class UserAuthPage extends StatefulWidget {
  const UserAuthPage({Key? key}) : super(key: key);

  @override
  State<UserAuthPage> createState() => _UserAuthPageState();
}

class _UserAuthPageState extends State<UserAuthPage> {
  bool ShowLoginPage = true;

  void toggleScreens() {
    setState(() {
      ShowLoginPage = !ShowLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ShowLoginPage) {
      return LoginPage(showDaftarPage: toggleScreens);
    } else {
      return DaftarPage(showLoginPage: toggleScreens);
    }
  }
}
