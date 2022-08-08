import 'package:alumni_fasilkom/admin/auth/AdminMainPage.dart';
import 'package:alumni_fasilkom/users/auth/UserMainPage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome to Flutter',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.19),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.crop_square,
                  color: Colors.white,
                ),
                onPressed: () {
                  //
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => AdminMainPage()));
                },
              )
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(105),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/id/9/91/Logo-Esa-Unggul.png',
                  height: 200,
                  width: 200,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 14, 96, 172),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(5)),
                child: const Icon(
                  Icons.navigate_next,
                  size: 40,
                  // color: Color.fromARGB(255, 235, 112, 32),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => UserMainPage()));
                },
              )
            ],
          ),
        ));
  }
}
