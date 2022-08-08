import 'package:alumni_fasilkom/users/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:alumni_fasilkom/users/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class DaftarPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const DaftarPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController tmpttgllahirController = TextEditingController();
  TextEditingController telponController = TextEditingController();
  TextEditingController thnAngkatanController = TextEditingController();

  Future userSignUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
      addUserDetails(
          namaController.text.trim(),
          emailController.text.trim(),
          nimController.text.trim(),
          tmpttgllahirController.text.trim(),
          telponController.text.trim(),
          thnAngkatanController.text.trim());
    }
  }

  Future addUserDetails(
    String nama,
    String email,
    String nim,
    String tmpttgllahir,
    String telpon,
    String thnAngkatan,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'nama': nama,
      'email': email,
      'nim': nim,
      'tmpttgllahir': tmpttgllahir,
      'telpon': telpon,
      'thnAngkatan': thnAngkatan,
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() == confirmPassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    namaController.dispose();
    nimController.dispose();
    tmpttgllahirController.dispose();
    telponController.dispose();
    thnAngkatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Buat Akun'),
            backgroundColor: Color.fromARGB(255, 14, 96, 172),
            leading: GestureDetector(
              onTap: widget.showLoginPage,
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
                        controller: namaController,
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
                        keyboardType: TextInputType.number,
                        controller: nimController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nomor Induk Mahasiswa (NIM)',
                            hintText: 'Masukkan NIM Anda'),
                        validator: (nimController) {
                          if (nimController != null &&
                              nimController.length < 11) {
                            return 'Silahkan Masukkan NIM Anda!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Alamat Email',
                            hintText: 'Masukkan Alamat Email Anda'),
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
                        controller: confirmPassController,
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
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: tmpttgllahirController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tempat & Tanggal Lahir',
                            hintText: 'Mis. Jakarta, 1 Januari 2000'),
                        validator: (tmpttgllahirController) {
                          if (tmpttgllahirController != null &&
                              tmpttgllahirController.length < 2) {
                            return 'Silahkan Masukkan Tempat & Tanggal Lahir Anda!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: telponController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nomor Telepon',
                            hintText: 'Masukkan Nomor Telepon Anda'),
                        validator: (telponController) {
                          if (telponController != null &&
                              telponController.length < 10) {
                            return 'Silahkan Masukkan Nomor Telepon Anda!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: thnAngkatanController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tahun Angkatan',
                            hintText: 'Mis. 2019'),
                        validator: (thnAngkatanController) {
                          if (thnAngkatanController != null &&
                              thnAngkatanController.length < 4) {
                            return 'Silahkan Masukkan Tahun Angkatan Anda!';
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
                            'Buat Akun',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          onPressed: () {
                            final isValidForm =
                                formKey.currentState!.validate();
                            if (isValidForm) {
                              userSignUp();
                            }
                          },
                        )),
                  ],
                )),
          )),
    );
  }
}
