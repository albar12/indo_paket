import 'dart:convert';
import 'dart:io' as Io;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/login/data_ws.dart';
import 'package:indo_paket/model/service_produksi.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/test_transaksi/test_transaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';
import '../home/home_page.dart';
import '../terima_barang/barcode_page.dart';

import 'package:http/http.dart' as http;

import '../terima_tarikan/terima_tarikan.dart';

class ProduksiPage extends StatefulWidget {
  final String? session;
  final String? sn_mesin;
  const ProduksiPage({
    super.key,
    this.session,
    this.sn_mesin,
  });

  @override
  State<ProduksiPage> createState() => _ProduksiPageState();
}

class _ProduksiPageState extends State<ProduksiPage> {
  TextEditingController sn = TextEditingController();

  XFile? photo;
  Io.File? file;

  final ImagePicker _picker = ImagePicker();

  void foto() async {
    photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    if (photo != null) {
      setState(() {
        file = Io.File(photo!.path);
      });
    }

    // print(photo!.path);
    // photofile = File(photo!.path);
  }

  void ubah_sn(String sn_mesin) {
    setState(() {
      sn.text = sn_mesin;
    });
  }

  bool isLoading = false;

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
                    builder: (ctx) => ListProduksiPag(
                          session: widget.session,
                        )),
                (route) => false);
          },
        ),
        title: Text("Produksi"),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
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
                                  type: 'produksi',
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            if (sn.text.isEmpty) {
                              dialog(
                                  "Silahkan Input Serial Number Terlebih Dahulu!");
                            } else {
                              foto();
                            }
                          },
                          child: Text("Foto Struk")),
                    ),
                    photo == null
                        ? Container()
                        : Container(
                            //show captured image
                            padding: EdgeInsets.all(30),
                            child: Image.file(
                              Io.File(photo!.path),
                              height: 200,
                            ),
                            //display captured image
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          // var foto_struk = File(photo?.path);
                          // print("${photo!.path}");
                          // DataWs? result = await ServicesProduksi.sendproduksi(
                          //   widget.session.toString(),
                          //   sn.text.toString(),
                          //   photofile,
                          //   timezone.toString(),
                          // );

                          if (sn.text.isEmpty) {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text(
                            //       "Serial Number Mesin Tidak Boleh Kosong!"),
                            //   duration: const Duration(seconds: 2),
                            // ));

                            dialog("Serial Number Mesin Tidak Boleh Kosong!");
                          } else if (photo == null && file == null) {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text("Foto Struk Tidak Boleh Kosong!"),
                            //   duration: const Duration(seconds: 2),
                            // ));
                            dialog("Foto Struk Tidak Boleh Kosong!");
                          } else {
                            var timezone = DateTime.now().timeZoneName;
                            Io.File photofile = Io.File(photo!.path);
                            photofile.readAsBytesSync().lengthInBytes;
                            print(photofile.readAsBytesSync().lengthInBytes);

                            bottomSheetKirim(
                                widget.session.toString(),
                                sn.text.toString(),
                                photofile,
                                timezone.toString());
                          }

//  sendtes(photofile, widget.session.toString(),
//                                 sn.text.toString(), timezone.toString());
//                             indicator();
                        },
                        child: Text("Submit"),
                      ),
                    )
                    // Container(
                    //   //show captured image
                    //   padding: EdgeInsets.all(30),
                    //   child: photo == null
                    //       ? Text("No image Path")
                    //       : Text("${photo!.path}"),
                    //   //display captured image
                    // ),
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
      String session, String sn_mesin, Io.File foto_struk, String timezone) {
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
                      Text("Apa Anda Ingin Submit Produksi?"),
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
                                  await ServicesProduksi.sendproduksi(
                                      session.toString(),
                                      sn_mesin.toString(),
                                      foto_struk,
                                      timezone.toString());
                              print(result?.statuscode);
                              if (result?.statuscode == '200' ||
                                  result?.statuscode == null) {
                                dialog(result?.errormsg);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => ListProduksiPag(
                                              session: widget.session,
                                            )),
                                    (route) => false);
                              } else {
                                Navigator.of(context).pop();
                                dialog(result?.errormsg);
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

  void sendtes(
      Io.File tes, String session, String sn_mesin, String timezone) async {
    print("testing");
    print(tes.path);
    final bytes = Io.File(tes.path).readAsBytesSync();
    String image_encode = base64Encode(bytes);
    print(image_encode);
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'tb_ci_sessions=rh8d491gjgci6o8tb3jg1m4o2ml05ela'
    };

    var request = http.Request(
        'POST',
        Uri.parse(
            'https://indopaket.jtracker.id/api_mobile/api_mobile/insert_produksi'));
    request.bodyFields = {
      'session': session.toString(),
      'foto_struk': image_encode,
      'sn_mesin': sn_mesin,
      'timezone': timezone,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    setState(() {
      isLoading = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: LinearProgressIndicator(),
      duration: const Duration(seconds: 3),
    ));
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      print(await response.stream.bytesToString());
      // print(await response.stream['ErrorMessage'].toString());
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text("Berhasil!"),
      //   duration: const Duration(seconds: 2),
      // ));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => HomePage(
                    session: widget.session,
                  )),
          (route) => false);
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget indicator() {
    return Center(
      child: Container(
        child: LinearProgressIndicator(),
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
