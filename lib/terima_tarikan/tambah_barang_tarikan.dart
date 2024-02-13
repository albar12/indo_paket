import 'package:flutter/material.dart';
import 'package:indo_paket/terima_tarikan/terima_tarikan.dart';

import '../dashboard/dashboard_page.dart';
import '../data/data_tambah_barang.dart';
import '../home/home_page.dart';
import '../model/service_tarikanbarang.dart';
import '../packing/list_packing_page.dart';
import '../packing_qc/list_packing_qc.dart';
import '../produksi/list_produksi_page.dart';
import '../terima_barang/barcode_page.dart';
import '../terima_barang/terima_barang_page.dart';
import '../test_transaksi/list_testransaksi_page.dart';
import '../unpacking/unpacking_page.dart';

class TambahBarangTarikanPage extends StatefulWidget {
  final String? session;
  final String? id_box;
  final String? nama_box;
  final String? sn_mesin;
  final String? tid_lama;

  const TambahBarangTarikanPage({
    super.key,
    this.session,
    this.id_box,
    this.nama_box,
    this.sn_mesin,
    this.tid_lama,
  });

  @override
  State<TambahBarangTarikanPage> createState() =>
      _TambahBarangTarikanPageState();
}

class _TambahBarangTarikanPageState extends State<TambahBarangTarikanPage> {
  TextEditingController sn = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController tid_lama = TextEditingController();

  Future? barangTarikanFuture;

  List tarikanInsert = [];
  List results = [];
  int _selectedIndex = 8;
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
    listBarangTarikan(widget.session.toString(), widget.id_box.toString(),
        search.text.toString());
    if (widget.sn_mesin != null) {
      ubahsn(widget.sn_mesin.toString());
    }

    if (widget.tid_lama != null) {
      ubahtid(widget.tid_lama.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Barang Tarikan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Serial Number',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: () {
                      // var produk =
                      //     (_valProduk != null) ? _valProduk : widget.produk;

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return BCPage(
                          session: widget.session,
                          tid_lama: tid_lama.text.toString(),
                          namaBox: widget.nama_box,
                          idBox: widget.id_box,
                          type: "tambah_tarikan",
                        );
                      }));
                    },
                  )),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: sn,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TID Lama',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: tid_lama,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // var produk =
                    //     (_valProduk != null) ? _valProduk : widget.produk;

                    var timezone = DateTime.now().timeZoneName;
                    print(
                        "${tid_lama.text.toString()} ${sn.text.toString()} ${widget.session} ${widget.id_box} ${timezone}");
                    if (tid_lama.text.isEmpty || sn.text.isEmpty) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Lengkapi Form Terlebih Dahulu!"),
                      //   duration: const Duration(seconds: 2),
                      // ));

                      dialog("Lengkapi Form Terlebih Dahulu!");
                    } else {
                      dialog(null);
                      DataTambahBarang? result =
                          await ServicesTarikanBarang.tambah_tarikan(
                        widget.session.toString(),
                        timezone.toString(),
                        sn.text.toString(),
                        tid_lama.text.toString(),
                        widget.id_box.toString(),
                      );
                      print("object");
                      print(result?.errormsg);
                      if (result?.errormsg == null) {
                        Navigator.of(context).pop();
                        setState(() {
                          barangTarikanFuture = null;
                          sn.clear();
                          tid_lama.text = '';
                        });
                        listBarangTarikan(widget.session.toString(),
                            widget.id_box.toString(), search.text.toString());
                      } else {
                        Navigator.of(context).pop();
                        dialog(result?.errormsg);
                      }
                    }
                  },
                  child: Text("Kirim"),
                ),
              ],
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
                        listBarangTarikan(widget.session.toString(),
                            widget.id_box.toString(), search.text.toString());
                      }),
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        search.clear();
                        listBarangTarikan(widget.session.toString(),
                            widget.id_box.toString(), search.text.toString());
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: barangTarikanFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          listBarangTarikan(widget.session.toString(),
                              widget.id_box.toString(), search.text.toString());
                        },
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: tarikanInsert.length,
                            itemBuilder: (context, index) {
                              return Flexible(
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${tarikanInsert[index]['tid_lama']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
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
                                                  Text("Serial Number :"),
                                                  Text(
                                                    "${tarikanInsert[index]['sn']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${tarikanInsert[index]['create_adm']}"),
                                                  Text(
                                                      "${tarikanInsert[index]['datetime']}")
                                                ],
                                              )
                                              // Spacer(),
                                              // Text(
                                              //   "${tarikanInsert[index]['NamaStatus']}",
                                              //   style: TextStyle(
                                              //     fontSize: 15,
                                              //     fontWeight: FontWeight.bold,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //   content: Text("${barangInsert[index]}"),
                                        //   duration: const Duration(seconds: 1),
                                        // ));

                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //   return TambahBarangPage();
                                        // }));
                                      },
                                    ),
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
            SizedBox(
              height: 10,
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: ElevatedButton(
            //     onPressed: (() {
            //       Navigator.of(context).pushAndRemoveUntil(
            //           MaterialPageRoute(
            //               builder: (ctx) => TerimaBarangPage(
            //                     session: widget.session,
            //                   )),
            //           (route) => false);
            //     }),
            //     child: Text("Kembali"),
            //   ),
            // )
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

  void ubahsn(String hasil) {
    if (this.mounted) {
      setState(() {
        sn.text = hasil.toString();
      });
    }
  }

  void ubahtid(String tid) {
    if (this.mounted) {
      setState(() {
        tid_lama.text = tid.toString();
      });
    }
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

  void listBarangTarikan(String session, String id_box, String search) async {
    setState(() {
      tarikanInsert.clear();
    });
    barangTarikanFuture =
        ServicesTarikanBarang.list_tarikan(session, id_box).then((value) {
      // if (this.mounted) {
      //   setState(() {
      //     barangInsert = value!;
      //   });
      // }

      if (value != null) {
        if (search == '') {
          print("kosong");
          if (this.mounted) {
            setState(() {
              tarikanInsert = value;
            });
          }
        } else {
          print("tidak kososng");
          print(value.length);
          // print(value);
          setState(() {
            tarikanInsert.clear();
          });
          for (var i = 0; i < value.length; i++) {
            if (value[i]['NamaBox']
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                value[i]['tid_lama']
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                value[i]['sn'].toLowerCase().contains(search.toLowerCase())) {
              tarikanInsert.add(value[i]);
            }
          }

          setState(() {
            tarikanInsert = results;
          });
        }
      }
    });
  }
}
