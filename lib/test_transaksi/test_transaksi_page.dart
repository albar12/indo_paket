import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/login/data_ws.dart';
import 'package:indo_paket/model/service_testransaksi.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../home/home_page.dart';
import '../terima_barang/barcode_page.dart';
import '../terima_tarikan/terima_tarikan.dart';

class TestTransaksiPage extends StatefulWidget {
  final String? session;
  final String? sn_mesin;

  const TestTransaksiPage({
    super.key,
    this.session,
    this.sn_mesin,
  });

  @override
  State<TestTransaksiPage> createState() => _TestTransaksiPageState();
}

class _TestTransaksiPageState extends State<TestTransaksiPage> {
  TextEditingController sn = TextEditingController();

  String? konfirmasi;

  XFile? photo;
  XFile? photo_test2;
  XFile? photo_test3;
  XFile? photo_test4;
  XFile? photo_test5;

  Io.File? file;
  Io.File? file_tes2;
  Io.File? file_tes3;
  Io.File? file_tes4;
  Io.File? file_tes5;

  final ImagePicker _picker = ImagePicker();

  void foto() async {
    photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    setState(() {
      file = Io.File(photo!.path);
    });

    print(file);

    // print(photo!.path);
    // photofile = File(photo!.path);
  }

  void foto_tes2() async {
    photo_test2 = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    setState(() {
      file_tes2 = Io.File(photo_test2!.path);
    });
  }

  void foto_tes3() async {
    photo_test3 = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    setState(() {
      file_tes3 = Io.File(photo_test3!.path);
    });
  }

  void foto_tes4() async {
    photo_test4 = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    setState(() {
      file_tes4 = Io.File(photo_test4!.path);
    });
  }

  void foto_tes5() async {
    photo_test5 = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    setState(() {
      file_tes5 = Io.File(photo_test4!.path);
    });
  }

  void ubah_sn(String sn_mesin) {
    setState(() {
      sn.text = sn_mesin;
    });
  }

  int _selectedIndex = 5;

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
      ubah_sn(widget.sn_mesin.toString());
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
                    builder: (ctx) => ListTestTransaksiPage(
                          session: widget.session,
                        )),
                (route) => false);
          },
        ),
        title: Text("Test Transaksi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
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
                            type: 'test_transaksi',
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
              Text(
                "Foto Test Transaksi Debit",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  if (sn.text.isEmpty) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Input Serial Number Terlebih Dahulu!"),
                    //   duration: const Duration(seconds: 2),
                    // ));
                    dialog("Input Serial Number Terlebih Dahulu!");
                  } else {
                    foto();
                  }
                },
                child: Card(
                    child: photo == null
                        ? Container(
                            child: Icon(Icons.camera_enhance),
                          )
                        : Image.file(
                            Io.File(photo!.path),
                            height: 200,
                          )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Foto Test Transaksi Flazz",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  if (sn.text.isEmpty) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Input Serial Number Terlebih Dahulu!"),
                    //   duration: const Duration(seconds: 2),
                    // ));
                    dialog("Input Serial Number Terlebih Dahulu!");
                  } else {
                    foto_tes2();
                  }
                },
                child: Card(
                    child: photo_test2 == null
                        ? Container(
                            child: Icon(Icons.camera_enhance),
                          )
                        : Image.file(
                            Io.File(photo_test2!.path),
                            height: 200,
                          )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Foto Test Transaksi QR",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  if (sn.text.isEmpty) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Input Serial Number Terlebih Dahulu!"),
                    //   duration: const Duration(seconds: 2),
                    // ));
                    dialog("Input Serial Number Terlebih Dahulu!");
                  } else {
                    foto_tes3();
                  }
                },
                child: Card(
                    child: photo_test3 == null
                        ? Container(
                            child: Icon(Icons.camera_enhance),
                          )
                        : Image.file(
                            Io.File(photo_test3!.path),
                            height: 200,
                          )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Foto Test Transaksi 1",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  if (sn.text.isEmpty) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Input Serial Number Terlebih Dahulu!"),
                    //   duration: const Duration(seconds: 2),
                    // ));
                    dialog("Input Serial Number Terlebih Dahulu!");
                  } else {
                    foto_tes4();
                  }
                },
                child: Card(
                    child: photo_test4 == null
                        ? Container(
                            child: Icon(Icons.camera_enhance),
                          )
                        : Image.file(
                            Io.File(photo_test4!.path),
                            height: 200,
                          )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Foto Test Transaksi 2",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  if (sn.text.isEmpty) {
                    dialog("Input Serial Number Terlebih Dahulu!");
                  } else {
                    foto_tes5();
                  }
                },
                child: Card(
                    child: photo_test5 == null
                        ? Container(
                            child: Icon(Icons.camera_enhance),
                          )
                        : Image.file(
                            Io.File(photo_test5!.path),
                            height: 200,
                          )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (sn.text.isEmpty) {
                      dialog("Serial Number Mesin Tidak Boleh Kosong!");
                    } else if (photo == null) {
                      dialog("Foto Test Transaksi Debit Tidak Boleh Kosong!");
                    } else if (photo_test2 == null) {
                      dialog("Foto Test Transaksi Flazz Tidak Boleh Kosong!");
                    } else if (photo_test3 == null) {
                      dialog("Foto Test Transaksi QR Tidak Boleh Kosong!");
                    } else if (photo_test4 == null) {
                      dialog("Foto Test Transaksi 1 Tidak Boleh Kosong!");
                    } else if (photo_test5 == null) {
                      dialog("Foto Test Transaksi 2 Tidak Boleh Kosong!");
                    } else {
                      var timezone = DateTime.now().timeZoneName;
                      Io.File photofile = Io.File(photo!.path);
                      Io.File photofile2 = Io.File(photo_test2!.path);
                      Io.File photofile3 = Io.File(photo_test3!.path);
                      Io.File photofile4 = Io.File(photo_test4!.path);
                      Io.File photofile5 = Io.File(photo_test5!.path);

                      bottomSheetKirim(
                          widget.session.toString(),
                          sn.text.toString(),
                          photofile,
                          photofile2,
                          photofile3,
                          photofile4,
                          photofile5,
                          timezone.toString());
                    }
                  },
                  child: Text("Submit"),
                ),
              )
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

  void bottomSheetKirim(
      String session,
      String sn_mesin,
      Io.File foto_tes1,
      Io.File foto_tes2,
      Io.File foto_tes3,
      Io.File foto_tes4,
      Io.File foto_tes5,
      String timezone) {
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
                      Text("Apa Anda Ingin Submit Test Transaksi?"),
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
                              DataWs? result = await ServicesTesTransaksi
                                  .insert_test_transaksi(
                                      session.toString(),
                                      sn_mesin.toString(),
                                      foto_tes1,
                                      foto_tes2,
                                      foto_tes3,
                                      foto_tes4,
                                      foto_tes5,
                                      timezone.toString());

                              print(result?.statuscode);

                              if (result?.statuscode == "200" ||
                                  result?.statuscode == null) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => ListTestTransaksiPage(
                                              session: widget.session,
                                            )),
                                    (route) => false);
                              } else if (result == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: LinearProgressIndicator(),
                                ));
                              } else {
                                Navigator.of(context).pop();
                                dialog(result.errormsg);
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
