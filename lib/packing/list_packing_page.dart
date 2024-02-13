import 'package:flutter/material.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/home/home_page.dart';
import 'package:indo_paket/model/service_packing.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../terima_tarikan/terima_tarikan.dart';

class ListPackingPage extends StatefulWidget {
  final String? session;
  const ListPackingPage({
    super.key,
    this.session,
  });

  @override
  State<ListPackingPage> createState() => _ListPackingPageState();
}

class _ListPackingPageState extends State<ListPackingPage> {
  TextEditingController search = TextEditingController();
  Future? listPackingFuture;

  List listPacking = [];

  List results = [];

  int _selectedIndex = 7;

  bool readonly = false;

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

  void getListPacking(String session, String search) {
    setState(() {
      results.clear();
    });
    listPackingFuture = ServicesPacking.getListPacking(session).then((value) {
      print(value!.data![0]);
      print(value.data![0]['sn'].contains("1"));
      print(search);

      if (value.data != null) {
        if (search == '') {
          if (this.mounted) {
            setState(() {
              listPacking = value.data!;
            });
          }
        } else {
          setState(() {
            results.clear();
          });
          for (var i = 0; i < value.data!.length; i++) {
            if (value.data![i]['sn']
                .toLowerCase()
                .contains(search.toLowerCase())) {
              results.add(value.data![i]);
            }
          }

          if (this.mounted) {
            setState(() {
              listPacking = results;
            });
          }
        }
      } else {
        dialog(value.errormsg);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListPacking(widget.session.toString(), search.text.toString());
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
        title: Text("List Packing"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (ctx) => PackingPage(
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
                      readOnly: readonly,
                      controller: search,
                      decoration: new InputDecoration(
                        hintText: 'Search By SN',
                        border: InputBorder.none,
                      ),
                      onChanged: ((value) {
                        results.clear();
                        getListPacking(
                            widget.session.toString(), search.text.toString());
                      }),
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        search.clear();
                        getListPacking(
                            widget.session.toString(), search.text.toString());
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: listPackingFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        getListPacking(
                            widget.session.toString(), search.text.toString());
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listPacking.length,
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
                                          Text("Serial Number :"),
                                          Text(
                                            "${listPacking[index]['sn']}",
                                            style: TextStyle(),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "${listPacking[index]['create_adm']}"),
                                          Text(
                                              "${listPacking[index]['datetime']}")
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        "${listPacking[index]['NamaStatus']}",
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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext) {
        return alertDialog;
      },
    );
  }

  // // This function is called whenever the text field changes
  // void _runFilter(String enteredKeyword) {
  //   // print(listPacking[1]['sn']);

  //   if (enteredKeyword.isEmpty) {
  //     setState(() {
  //       listPacking = listPacking;
  //     });
  //   } else {
  //     for (var i = 0; i < listPacking.length; i++) {
  //       if (listPacking[i]['sn']
  //           .toLowerCase()
  //           .contains(enteredKeyword.toLowerCase())) {
  //         results.add(listPacking[i]);
  //       }
  //     }
  //     setState(() {
  //       listPacking = results;
  //     });
  //   }

  //   // if (enteredKeyword.isEmpty) {
  //   //   // if the search field is empty or only contains white-space, we'll display all users
  //   //   results = listPacking;
  //   // } else {
  //   //   results = listPacking
  //   //       .where((user) => user["data"]['sn']
  //   //           .toLowerCase()
  //   //           .contains(enteredKeyword.toLowerCase()))
  //   //       .toList();
  //   //   // we use the toLowerCase() method to make it case-insensitive
  //   // }

  //   // // Refresh the UI
  //   // setState(() {
  //   //   listPacking = results;
  //   // });
  // }
}
