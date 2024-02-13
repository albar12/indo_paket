import 'package:flutter/material.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/laporan/laporan_page.dart';
import 'package:indo_paket/logout/logout_page.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/terima_tarikan/terima_tarikan.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/test_transaksi/test_transaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../model/shared_preferances.dart';

class HomePage extends StatefulWidget {
  final String? session;
  const HomePage({
    super.key,
    this.session,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? session;
  String? name;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    // setState(() {
    //   _selectedIndex = index;
    // });

    print(index);
    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => HomePage(
                    session: widget.session,
                  )),
          (route) => false);
    } else if (index == 1) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => DashboardPage(
                    session: widget.session,
                  )),
          (route) => true);
    } else if (index == 2) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => TerimaBarangPage(
                    session: widget.session,
                  )),
          (route) => true);
    } else if (index == 3) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => UnpackingPage(
                    session: widget.session,
                  )),
          (route) => true);
    } else if (index == 4) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => ListProduksiPag(
                    session: widget.session,
                  )),
          (route) => true);
    } else if (index == 5) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => ListTestTransaksiPage(
                    session: widget.session,
                  )),
          (route) => true);
    } else if (index == 6) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => ListPackingQCPage(
                    session: widget.session,
                  )),
          (route) => true);
    } else if (index == 7) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => ListPackingPage(
                    session: widget.session,
                  )),
          (route) => true);
    } else if (index == 8) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => TerimaTarikanPage(
                    session: widget.session,
                  )),
          (route) => true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.session);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _drawerHeader(),
            ListTile(
                title: Row(
                  children: [
                    Icon(Icons.logout),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                onTap: (() {
                  return showLogoutDialog(session.toString());
                }))
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.dashboard,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Dashboard",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("${session}"),
                      //   duration: const Duration(seconds: 1),
                      // ));

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => DashboardPage(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.archive,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Terima Barang Baru",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("${session}"),
                      //   duration: const Duration(seconds: 1),
                      // ));

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => TerimaBarangPage(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.all_inbox,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Unpacking",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => UnpackingPage(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.inventory_2,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Produksi",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => ListProduksiPag(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.add_card,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Test Transaksi",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => ListTestTransaksiPage(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.high_quality,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "QC",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => ListPackingQCPage(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.card_giftcard,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Packing",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => ListPackingPage(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.receipt_outlined,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Laporan",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => LaporanPage(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 150,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue,
                                  child: Icon(
                                    Icons.upload,
                                    size: 50.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Terima Barang Tarikan",
                                  style: TextStyle(
                                    fontFamily: 'NotoSerif',
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (ctx) => TerimaTarikanPage(
                                    session: session,
                                  )),
                          (route) => true);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Colors.black,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive,
              color: Colors.black,
            ),
            label: 'Terima Barang',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.all_inbox,
              color: Colors.black,
            ),
            label: 'Unpacking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.inventory_2,
              color: Colors.black,
            ),
            label: 'Produksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_card,
              color: Colors.black,
            ),
            label: 'Test Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.high_quality,
              color: Colors.black,
            ),
            label: 'QC',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_giftcard,
              color: Colors.black,
            ),
            label: 'Packing',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload,
              color: Colors.black,
            ),
            label: 'Terima Barang Tarikan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  load() async {
    session = await SharedPref.getString("session");
    name = await SharedPref.getString("name");
    print(session);
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
    }
  }

  _drawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(
        '${name}',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      accountEmail: Text(""),
    );
  }

  void showLogoutDialog(String session) {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return LogoutPage(
          session: session,
        );
      },
    );
  }
}
