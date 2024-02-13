import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/home/home_page.dart';
import 'package:indo_paket/login/data_send_unpacking.dart';
import 'package:indo_paket/login/data_ws.dart';
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
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../terima_barang/barcode_page.dart';
import '../terima_tarikan/terima_tarikan.dart';

class TambahUnpackingPage extends StatefulWidget {
  final String? session;
  final String? sn_mesin;
  final String? sn_provider;
  final String? sn_psam;
  final String? sn_psam2;

  const TambahUnpackingPage({
    super.key,
    this.session,
    this.sn_mesin,
    this.sn_provider,
    this.sn_psam,
    this.sn_psam2,
  });

  @override
  State<TambahUnpackingPage> createState() => _TambahUnpackingPageState();
}

class _TambahUnpackingPageState extends State<TambahUnpackingPage> {
  TextEditingController sn = TextEditingController();
  TextEditingController sn_provider = TextEditingController();
  TextEditingController sn_psam = TextEditingController();
  TextEditingController sn_psam2 = TextEditingController();
  TextEditingController catatan = TextEditingController();

  File? photofile;
  XFile? photo;
  final ImagePicker _picker = ImagePicker();

  void foto() async {
    photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {});
    // print(photo!.path);
    // photofile = File(photo!.path);
  }

  void ubah_snMesin(String mesinSN) {
    setState(() {
      sn.text = mesinSN.toString();
    });
  }

  void ubah_snProvider(String providerSN) {
    setState(() {
      sn_provider.text = providerSN;
    });
  }

  void ubah_snPsam(String psamSN) {
    setState(() {
      sn_psam.text = psamSN;
    });
  }

  void ubah_snPsam2(String psamSN2) {
    setState(() {
      sn_psam2.text = psamSN2;
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
    if (widget.sn_mesin != null) {
      ubah_snMesin(widget.sn_mesin.toString());
    }

    if (widget.sn_provider != null) {
      ubah_snProvider(widget.sn_provider.toString());
    }

    if (widget.sn_psam != null) {
      ubah_snPsam(widget.sn_psam.toString());
    }

    print("sn_psam2");
    print(widget.sn_psam2);

    if (widget.sn_psam2 != null) {
      ubah_snPsam2(widget.sn_psam2.toString());
    }
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
                    builder: (ctx) => UnpackingPage(
                          session: widget.session,
                        )),
                (route) => false);
          },
        ),
        title: Text('Tambah Unpacking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Serial Number Mesin',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.qr_code_scanner),
                      onPressed: () {
                        // var produk =
                        //     (_valProduk != null) ? _valProduk : widget.produk;

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BCPage(
                            session: widget.session,
                            sn_mesin: sn.text.toString(),
                            sn_provider: sn_provider.text.toString(),
                            sn_psam: sn_psam.text.toString(),
                            sn_psam2: sn_psam2.text.toString(),
                            sub_type: 'sn_mesin',
                            type: 'unpacking',
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
                    labelText: 'Serial Number Provider',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.qr_code_scanner),
                      onPressed: () {
                        // var produk =
                        //     (_valProduk != null) ? _valProduk : widget.produk;

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BCPage(
                            session: widget.session,
                            sn_mesin: sn.text.toString(),
                            sn_provider: sn_provider.text.toString(),
                            sn_psam: sn_psam.text.toString(),
                            sn_psam2: sn_psam2.text.toString(),
                            sub_type: 'sn_provider',
                            type: 'unpacking',
                          );
                        }));
                      },
                    )),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: sn_provider,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Serial Number Psam',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.qr_code_scanner),
                      onPressed: () {
                        // var produk =
                        //     (_valProduk != null) ? _valProduk : widget.produk;

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BCPage(
                            session: widget.session,
                            sn_mesin: sn.text.toString(),
                            sn_provider: sn_provider.text.toString(),
                            sn_psam: sn_psam.text.toString(),
                            sn_psam2: sn_psam2.text.toString(),
                            sub_type: 'sn_psam',
                            type: 'unpacking',
                          );
                        }));
                      },
                    )),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: sn_psam,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Serial Number Psam2',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.qr_code_scanner),
                      onPressed: () {
                        // var produk =
                        //     (_valProduk != null) ? _valProduk : widget.produk;

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BCPage(
                            session: widget.session,
                            sn_mesin: sn.text.toString(),
                            sn_provider: sn_provider.text.toString(),
                            sn_psam: sn_psam.text.toString(),
                            sn_psam2: sn_psam2.text.toString(),
                            sub_type: 'sn_psam2',
                            type: 'unpacking',
                          );
                        }));
                      },
                    )),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: sn_psam2,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Catatan',
                ),
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                controller: catatan,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      if (sn.text.isEmpty || sn_provider.text.isEmpty) {
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text("Lengkapi Form Terlebih Dahulu!"),
                        //   duration: const Duration(seconds: 2),
                        // ));
                        // ||
                        //   sn_psam.text.isEmpty
                        dialog("Lengkapi Form Terlebih Dahulu!");
                      } else {
                        print(
                            "${sn.text.toString()} ${sn_provider.text.toString()} ${sn_psam.text.toString()}");

                        var timezone = DateTime.now().timeZoneName;
                        DataSendUnpacking? dataSend = DataSendUnpacking();
                        dataSend.sn_mesin = sn.text.toString();
                        dataSend.sn_provider = sn_provider.text.toString();
                        dataSend.sn_psam = sn_psam.text.toString();
                        dataSend.catatan = catatan.text.toString();
                        dataSend.timezone = timezone.toString();
                        dataSend.sn_psam2 = sn_psam2.text.toString();

                        bottomSheetKirim(dataSend);
                      }
                    },
                    child: Text("Submit")),
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

  void bottomSheetKirim(DataSendUnpacking data) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Apa Anda Ingin Melakukan Submit Unpacking?"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: const Text('Tidak'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            child: const Text('Ya'),
                            onPressed: () async {
                              dialog(null);
                              DataWs? result =
                                  await ServicesUnpacking.sendunpacking(
                                      widget.session.toString(),
                                      data.sn_mesin.toString(),
                                      data.sn_provider.toString(),
                                      data.sn_psam.toString(),
                                      data.timezone.toString(),
                                      data.catatan.toString(),
                                      data.sn_psam2.toString());
                              print(result?.statuscode);
                              if (result?.statuscode == null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => UnpackingPage(
                                              session: widget.session,
                                            )),
                                    (route) => false);
                              } else {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: LinearProgressIndicator(),
                                  duration: const Duration(seconds: 2),
                                ));
                                Navigator.of(context).pop();
                                dialog(result?.errormsg.toString());
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
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
