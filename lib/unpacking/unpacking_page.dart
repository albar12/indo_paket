import 'package:flutter/material.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/home/home_page.dart';
import 'package:indo_paket/model/service_unpacking.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/test_transaksi/test_transaksi_page.dart';
import 'package:indo_paket/unpacking/tambah_unpacking_page.dart';

import '../terima_tarikan/terima_tarikan.dart';

class UnpackingPage extends StatefulWidget {
  final String? session;
  const UnpackingPage({
    super.key,
    this.session,
  });

  @override
  State<UnpackingPage> createState() => _UnpackingPageState();
}

class _UnpackingPageState extends State<UnpackingPage> {
  TextEditingController search = TextEditingController();
  List listUnpacking = [];

  List results = [];

  Future? unpackingFuture;

  void list_unpacking(String session, String search) async {
    setState(() {
      listUnpacking.clear();
    });
    unpackingFuture = ServicesUnpacking.getListUnpacking(session).then((value) {
      // print(value);
      // if (this.mounted) {
      //   setState(() {
      //     listUnpacking = value!;
      //   });
      // }

      if (value != null) {
        if (search == '') {
          print("kosong");
          if (this.mounted) {
            setState(() {
              listUnpacking = value;
            });
          }
        } else {
          print("tidak kososng");
          print(value.length);
          // print(value);
          setState(() {
            listUnpacking.clear();
          });
          for (var i = 0; i < value.length; i++) {
            print(value[i]['sn'].toLowerCase().contains(search.toLowerCase()));
            if (value[i]['sn'].toLowerCase().contains(search.toLowerCase())) {
              print(value[i]['sn']);
              listUnpacking.add(value[i]);
            }
          }
          print("asdada");
          print(results);

          setState(() {
            listUnpacking = results;
          });
        }
      }
    });
  }

  int _selectedIndex = 3;

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
    list_unpacking(widget.session.toString(), search.text.toString());
    print(widget.session);
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
                (route) => false);
          },
        ),
        title: Text('Unpacking'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (ctx) => TambahUnpackingPage(
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
        child: Center(
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
                          list_unpacking(widget.session.toString(),
                              search.text.toString());
                        }),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          search.clear();
                          list_unpacking(widget.session.toString(),
                              search.text.toString());
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: unpackingFuture,
                    builder: (context, snapshot) {
                      print(snapshot.hasError);
                      if (snapshot.connectionState == ConnectionState.done) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            list_unpacking(widget.session.toString(),
                                search.text.toString());
                          },
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: listUnpacking.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("SN MESIN :"),
                                              Text(
                                                "${listUnpacking[index]['sn']}",
                                                style: TextStyle(),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("SN SIMCARD :"),
                                              Text(
                                                  "${listUnpacking[index]['simcard']}"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text("SN PSAM :"),
                                              Text(
                                                  "${listUnpacking[index]['psam']}"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  "${listUnpacking[index]['create_adm']}"),
                                              Text(
                                                  "${listUnpacking[index]['datetime']}")
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            "${listUnpacking[index]['status'].toUpperCase()}",
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
                          child: Column(
                            children: [
                              SizedBox(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
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
}
