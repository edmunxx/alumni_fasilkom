import 'package:alumni_fasilkom/admin/auth/adminMainPage.dart';
import 'package:alumni_fasilkom/users/auth/UserMainPage.dart';
import 'package:flutter/material.dart';
import 'package:alumni_fasilkom/admin/AdminLogin.dart';
import 'package:alumni_fasilkom/users/DaftarPage.dart';
import 'package:alumni_fasilkom/users/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showDaftarPage;
  const LoginPage({Key? key, required this.showDaftarPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future userSignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => UserMainPage()));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Alamat Email',
                          hintText: 'Masukkan Alamat Email Anda',
                        ),
                        validator: (emailController) =>
                            emailController != null &&
                                    !EmailValidator.validate(emailController)
                                ? 'Silahkan Masukkan Alamat Email Anda!'
                                : null,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
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
                            final isValidForm =
                                formKey.currentState!.validate();
                            if (isValidForm) {
                              userSignIn();
                            }
                          },
                        )),
                    GestureDetector(
                      onTap: widget.showDaftarPage,
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
          )),
    );
  }
}
