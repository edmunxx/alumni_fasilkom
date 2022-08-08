import 'package:alumni_fasilkom/users/LoginPage.dart';
import 'package:alumni_fasilkom/admin/AdminDaftar.dart';
import 'package:alumni_fasilkom/admin/AdminLogin.dart';
import 'package:alumni_fasilkom/users/DaftarPage.dart';
import 'package:flutter/material.dart';

class AdminAuthPage extends StatefulWidget {
  const AdminAuthPage({Key? key}) : super(key: key);

  @override
  State<AdminAuthPage> createState() => _AdminAuthPageState();
}

class _AdminAuthPageState extends State<AdminAuthPage> {
  bool ShowAdminLogin = true;

  void toggleScreens() {
    setState(() {
      ShowAdminLogin = !ShowAdminLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ShowAdminLogin) {
      return AdminLogin(showAdminDaftar: toggleScreens);
    } else {
      return AdminDaftar(showAdminLogin: toggleScreens);
    }
  }
}
