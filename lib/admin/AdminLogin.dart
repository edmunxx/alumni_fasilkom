import 'package:alumni_fasilkom/admin/AdminHome.dart';
import 'package:alumni_fasilkom/admin/auth/AdminMainPage.dart';
import 'package:flutter/material.dart';
import 'package:alumni_fasilkom/admin/AdminDaftar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatefulWidget {
  final VoidCallback showAdminDaftar;
  const AdminLogin({Key? key, required this.showAdminDaftar}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailAdminController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();

  Future adminSignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAdminController.text.trim(),
        password: passwordAdminController.text.trim());
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => AdminMainPage()));
  }

  @override
  void dispose() {
    emailAdminController.dispose();
    passwordAdminController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(
                        'Mobile Alumni Fasilkom',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                          color: Color.fromARGB(255, 14, 96, 172),
                        ),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Admin',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      )),
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
                          hintText: 'Masukkan Password Anda'),
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
                      height: 70,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 14, 96, 172),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        onPressed: () {
                          final isValidForm = formKey.currentState!.validate();
                          if (isValidForm) {
                            adminSignIn();
                          }
                        },
                      )),
                  GestureDetector(
                    onTap: widget.showAdminDaftar,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Belum memiliki Akun? Daftar',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 14, 96, 172),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
