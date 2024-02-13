import 'package:flutter/material.dart';
import 'package:indo_paket/login/login_page.dart';

import 'home/home_page.dart';
import 'model/shared_preferances.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: MyApp(),
      home: const CekLogin(),
      // home: const MyHomePage(),
    );
  }
}

class CekLogin extends StatefulWidget {
  const CekLogin({super.key});

  @override
  State<CekLogin> createState() => _CekLoginState();
}

class _CekLoginState extends State<CekLogin> {
  String? session_login;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cek_login();
  }

  @override
  Widget build(BuildContext context) {
    print("${session_login} + login");
    return session_login != "null" ? HomePage() : LoginPage();
    // return LoginPage();
  }

  cek_login() async {
    String? tes = await SharedPref.getString('session');
    if (tes != null) {
      setState(() {
        session_login = tes;
      });
    }
  }
}
