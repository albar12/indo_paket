import 'package:flutter/material.dart';
import 'package:indo_paket/login/data_ws.dart';
import 'package:indo_paket/login/login_page.dart';
import 'package:indo_paket/model/service_logout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPage extends StatefulWidget {
  final String? session;
  const LogoutPage({
    super.key,
    this.session,
  });

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Apa Anda Yakin Akan Logout?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) {
            //   return LoginPage();
            // }));

            dialog(null);
            DataWs? result =
                await ServiceLogout.logout(widget.session.toString());
            if (result?.statuscode == '200' || result?.errormsg == null) {
              clearPrefs();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => LoginPage()),
                  (route) => false);
            } else {
              Navigator.of(context).pop();
              dialog(result?.errormsg);
            }
          },
          child: Text("Oke"),
        )
      ],
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

  clearPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
