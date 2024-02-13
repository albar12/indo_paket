import 'package:flutter/material.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/data/data_lisbox.dart';
import 'package:indo_paket/model/service_tambahbarang.dart';
import 'package:indo_paket/model/service_terimabarang.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/tambah_barang_page.dart';
import 'package:indo_paket/terima_barang/tambah_box_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../home/home_page.dart';
import '../terima_tarikan/terima_tarikan.dart';
import '../test_transaksi/test_transaksi_page.dart';

class TerimaBarangPage extends StatefulWidget {
  final String? session;
  const TerimaBarangPage({
    super.key,
    this.session,
  });

  @override
  State<TerimaBarangPage> createState() => _TerimaBarangPageState();
}

class _TerimaBarangPageState extends State<TerimaBarangPage> {
  TextEditingController search = TextEditingController();

  List box = [];

  List results = [];

  Future? boxFutue;

  void listbox(String session, String search) async {
    setState(() {
      box.clear();
    });
    boxFutue = ServicesTerimaBarang.listBox(session).then((value) {
      // if (this.mounted) {
      //   setState(() {
      //     box = value!;
      //   });
      // }

      if (value != null) {
        if (search == '') {
          print("kosong");
          if (this.mounted) {
            setState(() {
              box = value;
            });
          }
        } else {
          print("tidak kososng");
          print(value.length);
          // print(value);
          setState(() {
            box.clear();
          });
          for (var i = 0; i < value.length; i++) {
            print(value[i]['NamaBox']
                .toLowerCase()
                .contains(search.toLowerCase()));
            if (value[i]['NamaBox']
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                value[i]['no_box']
                    .toLowerCase()
                    .contains(search.toLowerCase())) {
              print(value[i]['NamaBox']);
              box.add(value[i]);
            }
          }
          print("asdada");
          print(results);

          setState(() {
            box = results;
          });
        }
      }
    });
  }

  int _selectedIndex = 2;

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
    print("ALif");
    print(widget.session.toString());
    listbox(widget.session.toString(), search.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => HomePage()),
                (route) => false);
          },
        ),
        title: Text("Terima Barang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (ctx) => TambahBoxPagw(
                                session: widget.session,
                              )),
                      (route) => true);
                },
                child: Text("Create Box"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
                        listbox(
                            widget.session.toString(), search.text.toString());
                      }),
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        search.clear();
                        listbox(
                            widget.session.toString(), search.text.toString());
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: boxFutue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      listbox(
                          widget.session.toString(), search.text.toString());
                    },
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "No Box : ${box[index]['no_box']}"),
                                              // Text(
                                              //   "${box[index]['no_box']}",
                                              //   style: TextStyle(
                                              //     fontSize: 15,
                                              //     fontWeight: FontWeight.bold,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Nama Box : ${box[index]['NamaBox']}"),
                                              // Text(
                                              //   "${box[index]['NamaBox']}",
                                              //   style: TextStyle(
                                              //     fontSize: 15,
                                              //     fontWeight: FontWeight.bold,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Jumlah : ${box[index]['jumlah']}"),
                                              // Text(
                                              //   "${box[index]['create_adm']}",
                                              //   style: TextStyle(fontSize: 12),
                                              // )
                                            ],
                                          ),
                                          // Spacer(),
                                          // Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text("Create Date :"),
                                          //     Text(
                                          //       "${box[index]['datetime']}",
                                          //       style: TextStyle(fontSize: 12),
                                          //     )
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Create Admin :"),
                                              Text(
                                                "${box[index]['create_adm']}",
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Create Date :"),
                                              Text(
                                                "${box[index]['datetime']}",
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(SnackBar(
                                  //   content: Text("${box[index]['ID']}"),
                                  //   duration: const Duration(seconds: 1),
                                  // ));

                                  // Navigator.pushReplacement(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return TambahBarangPage(
                                  //     box: box[index],
                                  //   );
                                  // }));
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (ctx) => TambahBarangPage(
                                                session: widget.session,
                                                nama_box: box[index]['NamaBox'],
                                                id_box: box[index]['ID'],
                                              )),
                                      (route) => true);
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
            )),
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
