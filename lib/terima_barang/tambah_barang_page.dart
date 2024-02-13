import 'package:flutter/material.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/data/data_tambah_barang.dart';
import 'package:indo_paket/home/home_page.dart';
import 'package:indo_paket/model/service_tambahbarang.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/barcode_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/test_transaksi/test_transaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../terima_tarikan/terima_tarikan.dart';

class TambahBarangPage extends StatefulWidget {
  String? session;
  String? nama_box;
  String? id_box;
  String? scan;
  String? produk;

  TambahBarangPage({
    super.key,
    this.nama_box,
    this.session,
    this.id_box,
    this.scan,
    this.produk,
  });

  @override
  State<TambahBarangPage> createState() => _TambahBarangPageState();
}

class _TambahBarangPageState extends State<TambahBarangPage> {
  List produkList = [];
  List barangInsert = [];
  List results = [];

  String? _valProduk;

  Future? barangInsertFutue;

  TextEditingController sn = TextEditingController();

  TextEditingController search = TextEditingController();

  void listProduk(String session) {
    ServicesTambahBarang.drop_produk(session).then((value) {
      if (this.mounted) {
        setState(() {
          produkList = value!;
        });
      }
    });
  }

  void listBarang(String session, String id_box, String search) async {
    setState(() {
      barangInsert.clear();
    });
    barangInsertFutue =
        ServicesTambahBarang.list_barang(session, id_box).then((value) {
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
              barangInsert = value;
            });
          }
        } else {
          print("tidak kososng");
          print(value.length);
          // print(value);
          setState(() {
            barangInsert.clear();
          });
          for (var i = 0; i < value.length; i++) {
            if (value[i]['NamaBox']
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                value[i]['NamaProduk']
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                value[i]['sn'].toLowerCase().contains(search.toLowerCase())) {
              barangInsert.add(value[i]);
            }
          }

          setState(() {
            barangInsert = results;
          });
        }
      }
    });
  }

  void ubahsn(String hasil) {
    if (this.mounted) {
      setState(() {
        sn.text = hasil.toString();
      });
    }
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
    listProduk(widget.session.toString());
    listBarang(widget.session.toString(), widget.id_box.toString(),
        search.text.toString());
    if (widget.scan != null) {
      ubahsn(widget.scan.toString());
    }

    print(widget.session);
    print(widget.nama_box);
    print(widget.id_box);
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
                    builder: (ctx) => TerimaBarangPage(
                          session: widget.session,
                        )),
                (route) => true);
          },
        ),
        title: Text("${widget.nama_box}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                  isExpanded: true,
                  value: _valProduk != null ? _valProduk : widget.produk,
                  hint: Text("Pilih Produk"),
                  items: produkList.map<DropdownMenuItem<dynamic>>(
                    (value) {
                      return DropdownMenuItem<String>(
                        value: value['ID'].toString(),
                        child: Text(value['NamaProduk'].toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _valProduk = value;
                    });
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Serial Number',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: () {
                      var produk =
                          (_valProduk != null) ? _valProduk : widget.produk;

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return BCPage(
                          session: widget.session,
                          produk: produk,
                          namaBox: widget.nama_box,
                          idBox: widget.id_box,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var produk =
                        (_valProduk != null) ? _valProduk : widget.produk;

                    var timezone = DateTime.now().timeZoneName;
                    print(
                        "${produk} ${sn.text.toString()} ${widget.session} ${widget.id_box} ${timezone}");
                    if (produk == null || sn.text.isEmpty) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Lengkapi Form Terlebih Dahulu!"),
                      //   duration: const Duration(seconds: 2),
                      // ));

                      dialog("Lengkapi Form Terlebih Dahulu!");
                    } else {
                      dialog(null);
                      DataTambahBarang? result =
                          await ServicesTambahBarang.add_barang(
                              widget.session.toString(),
                              produk.toString(),
                              sn.text.toString(),
                              widget.id_box.toString(),
                              timezone.toString());
                      if (result?.errormsg == null) {
                        Navigator.of(context).pop();

                        setState(() {
                          barangInsertFutue = null;
                          sn.clear();
                          produk = null;
                        });
                        listBarang(widget.session.toString(),
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
                        listBarang(widget.session.toString(),
                            widget.id_box.toString(), search.text.toString());
                      }),
                    ),
                    trailing: new IconButton(
                      icon: new Icon(Icons.cancel),
                      onPressed: () {
                        search.clear();
                        listBarang(widget.session.toString(),
                            widget.id_box.toString(), search.text.toString());
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: barangInsertFutue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          listBarang(widget.session.toString(),
                              widget.id_box.toString(), search.text.toString());
                        },
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: barangInsert.length,
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
                                            "${barangInsert[index]['NamaProduk']}",
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
                                                    "${barangInsert[index]['sn']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                      "${barangInsert[index]['create_adm']}"),
                                                  Text(
                                                      "${barangInsert[index]['datetime']}")
                                                ],
                                              ),
                                              Spacer(),
                                              Text(
                                                "${barangInsert[index]['NamaStatus']}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
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
            // SizedBox(
            //   height: 10,
            // ),
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
}
