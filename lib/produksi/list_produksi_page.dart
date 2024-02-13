import 'package:flutter/material.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/home/home_page.dart';
import 'package:indo_paket/model/service_produksi.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/test_transaksi/test_transaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../terima_tarikan/terima_tarikan.dart';

class ListProduksiPag extends StatefulWidget {
  final String? session;
  const ListProduksiPag({
    super.key,
    this.session,
  });

  @override
  State<ListProduksiPag> createState() => _ListProduksiPagState();
}

class _ListProduksiPagState extends State<ListProduksiPag> {
  TextEditingController search = TextEditingController();
  int _selectedIndex = 4;

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

  List listProduksi = [];

  List results = [];

  Future? futureProduksi;

  void getListProduksi(String session, String search) {
    setState(() {
      listProduksi.clear();
    });
    futureProduksi = ServicesProduksi.listProduksi(session).then((value) {
      // setState(() {
      //   listProduksi = value!;
      // });

      if (value != null) {
        if (search == '') {
          print("kosong");
          if (this.mounted) {
            setState(() {
              listProduksi = value;
            });
          }
        } else {
          print("tidak kososng");
          print(value.length);
          // print(value);
          setState(() {
            listProduksi.clear();
          });
          for (var i = 0; i < value.length; i++) {
            print(value[i]['sn'].toLowerCase().contains(search.toLowerCase()));
            if (value[i]['sn'].toLowerCase().contains(search.toLowerCase())) {
              print(value[i]['sn']);
              listProduksi.add(value[i]);
            }
          }
          print("asdada");
          print(results);

          setState(() {
            listProduksi = results;
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListProduksi(widget.session.toString(), search.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (ctx) => HomePage(
                          session: widget.session,
                        )),
                (route) => true);
          },
        ),
        title: Text("List Produksi"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (ctx) => ProduksiPage(
                              session: widget.session,
                            )),
                    (route) => true);
              },
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: search,
                      decoration: new InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                      onChanged: ((value) {
                        // results.clear();
                        getListProduksi(
                            widget.session.toString(), search.text.toString());
                      }),
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        search.clear();
                        getListProduksi(
                            widget.session.toString(), search.text.toString());
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: futureProduksi,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        getListProduksi(
                            widget.session.toString(), search.text.toString());
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listProduksi.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("SN MESIN :"),
                                          Text(
                                            "${listProduksi[index]['sn']}",
                                            style: TextStyle(),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${listProduksi[index]['create_adm']}"),
                                          Text(
                                              "${listProduksi[index]['datetime']}")
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        "${listProduksi[index]['NamaStatus'].toUpperCase()}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(SnackBar(
                                    //   content: Text("${listUnpacking[index]}"),
                                    //   duration: const Duration(seconds: 2),
                                    // ));
                                  },
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: Container(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            )
          ],
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
}
