import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:indo_paket/login/data_login.dart';
import 'package:indo_paket/login/service_login.dart';

import '../home/home_page.dart';
import '../model/shared_preferances.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passVisibility = true;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "IDM PROJECT",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "with your account",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.account_box),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: username,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.key_sharp),
                    suffixIcon: IconButton(
                      icon: _passVisibility
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        _passVisibility = !_passVisibility;

                        setState(() {});
                      },
                    )),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                controller: password,
                obscureText: _passVisibility,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Text(
                      "Forgot Your Password?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: Text("SIGN IN"),
                  onPressed: () async {
                    if (username.text.isEmpty || password.text.isEmpty) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Username & Password Tidak Boleh Kosong"),
                      //   duration: const Duration(seconds: 1),
                      // ));

                      dialog("Username & Password Tidak Boleh Kosong");
                    } else {
                      dialog(null);
                      DataLogin? result = await ServiceLogin.login(
                          username.text.toString(), password.text.toString());
                      print(result);
                      if (result?.errorMsg == null && result != null) {
                        setPref(result);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (ctx) => HomePage()),
                            (route) => false);
                      } else if (result == null) {
                        dialog(
                            "Response Terlalu Panjang Silahkan Mencoba Untuk Mengganti Jaringan");
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text("${result?.errorMsg}"),
                        //   duration: const Duration(seconds: 2),
                        // ));
                        Navigator.of(context).pop();
                        dialog(result.errorMsg);
                      }
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return HomePage();
                      // }));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void dialog(String? msg) {
    TextButton okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("OK"),
    );

    AlertDialog alertDialog = AlertDialog(
      content: Text('${msg}'),
      actions: [
        okButton,
      ],
    );

    AlertDialog alertIndicator = AlertDialog(
      content: Container(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext) {
        return msg != null ? alertDialog : alertIndicator;
      },
    );
  }

  // set shared preferences
  void setPref(DataLogin result) async {
    SharedPref.setString("session", result.session.toString());
    SharedPref.setString("name", result.name.toString());
    SharedPref.setString("nik", result.nik.toString());
    SharedPref.setString("ktp", result.ktp.toString());
    SharedPref.setString("phone", result.phone.toString());
    SharedPref.setString(
        "workingStartDate", result.workingStartDate.toString());
    SharedPref.setString("workingEndDate", result.workingEndDate.toString());
    SharedPref.setString(
        "letterOfAssignmentPCS", result.letterOfAssignmentPCS.toString());
    SharedPref.setString(
        "letterOfAssignmentMTI", result.letterOfAssignmentMTI.toString());
  }
}
