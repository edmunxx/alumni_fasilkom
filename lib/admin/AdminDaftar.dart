import 'package:alumni_fasilkom/admin/AdminHome.dart';
import 'package:alumni_fasilkom/admin/AdminLogin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class AdminDaftar extends StatefulWidget {
  final VoidCallback showAdminLogin;
  const AdminDaftar({Key? key, required this.showAdminLogin}) : super(key: key);

  @override
  State<AdminDaftar> createState() => _AdminDaftarState();
}

class _AdminDaftarState extends State<AdminDaftar> {
  final formKey = GlobalKey<FormState>();
  TextEditingController namaAdminController = TextEditingController();
  TextEditingController emailAdminController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();
  TextEditingController confirmPassAdminController = TextEditingController();

  Future adminSignUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAdminController.text.trim(),
        password: passwordAdminController.text.trim(),
      );
      addAdminDetails(
        namaAdminController.text.trim(),
        emailAdminController.text.trim(),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AdminHome()));
    }
  }

  Future addAdminDetails(
    String nama,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('admin').add({
      'nama': nama,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (passwordAdminController.text.trim() ==
        confirmPassAdminController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Buat Akun Admin'),
          backgroundColor: Color.fromARGB(255, 14, 96, 172),
          leading: GestureDetector(
            onTap: widget.showAdminLogin,
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: namaAdminController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nama Lengkap',
                          hintText: 'Masukkan Nama Lengkap Anda'),
                      validator: (namaController) {
                        if (namaController != null &&
                            namaController.length < 2) {
                          return 'Silahkan Masukkan Nama Lengkap Anda!';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailAdminController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Alamat Email',
                          hintText: 'Masukkan Alamat Email Anda'),
                      validator: (emailController) => emailController != null &&
                              !EmailValidator.validate(emailController)
                          ? 'Silahkan Masukkan Alamat Email Anda!'
                          : null,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordAdminController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Masukkan Password maks. 8 karakter'),
                      validator: (passwordController) {
                        if (passwordController != null &&
                            passwordController.length < 8) {
                          return 'Silahkan Masukkan Password Anda!';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmPassAdminController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Konfirmasi Password',
                          hintText: 'Ulangi Password Anda'),
                      validator: (passwordController) {
                        if (passwordController != null &&
                            passwordController.length < 8) {
                          return 'Ulangi Password Anda!';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                      height: 70,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 14, 96, 172),
                        ),
                        child: const Text(
                          'Buat Akun Admin',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onPressed: () {
                          final isValidForm = formKey.currentState!.validate();
                          if (isValidForm) {
                            adminSignUp();
                          }
                        },
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
