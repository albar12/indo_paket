import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/home/home_page.dart';
import 'package:indo_paket/login/data_ws.dart';
import 'package:indo_paket/model/service_packing.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/test_transaksi/test_transaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../terima_tarikan/terima_tarikan.dart';

class PackingPage extends StatefulWidget {
  final String? session;
  const PackingPage({
    super.key,
    this.session,
  });

  @override
  State<PackingPage> createState() => _PackingPageState();
}

class _PackingPageState extends State<PackingPage> {
  TextEditingController tid = TextEditingController();

  bool visible = false;

  XFile? packing1;
  XFile? packing2;

  Io.File? file_packing1;
  Io.File? file_packing2;

  final ImagePicker _picker = ImagePicker();

  void foto_packing1() async {
    packing1 = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    setState(() {
      file_packing1 = Io.File(packing1!.path);
    });
  }

  void foto_packing2() async {
    packing2 = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    setState(() {
      file_packing2 = Io.File(packing2!.path);
    });
  }

  int _selectedIndex = 7;

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

  Future? tidFuture;

  List packingList = [];

  void cek_tid(String session, String tid) {
    tidFuture = ServicesPacking.cekTid(session, tid).then((value) {
      if (value?.statuscode == '200' || value?.data != null) {
        setState(() {
          packingList = value!.data!;
          visible = true;
        });
      } else {
        setState(() {
          visible = false;
        });
        dialog(value?.errormsg);
      }
    });
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
                    builder: (ctx) => ListPackingPage(
                          session: widget.session,
                        )),
                (route) => false);
          },
        ),
        title: Text("Packing"),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'TID',
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: tid,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: (() {
                        setState(() {
                          visible = false;
                          packing1 = null;
                          packing2 = null;
                          file_packing1 = null;
                          file_packing2 = null;
                          tid.text = '';
                        });
                      }),
                      child: Text("Cancel"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        if (tid.text.isEmpty) {
                          dialog("Silahkan Input TID Terlebih Dahulu");
                        } else {
                          cek_tid(
                              widget.session.toString(), tid.text.toString());
                        }
                      }),
                      child: Text("Cek"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: tidFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Visibility(
                        visible: visible,
                        child: Column(
                          children: [
                            ListView.builder(
                              // scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: packingList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'No Box',
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      controller: TextEditingController(
                                        text: "${packingList[index]['no_box']}",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Serial Number',
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      controller: TextEditingController(
                                        text: "${packingList[index]['sn']}",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Foto Packing",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        foto_packing1();
                                      },
                                      child: Card(
                                          child: file_packing1 == null
                                              ? Container(
                                                  child: Icon(
                                                    Icons.camera_enhance,
                                                    size: 150,
                                                  ),
                                                )
                                              : Image.file(
                                                  Io.File(file_packing1!.path),
                                                  height: 200,
                                                )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Foto AWB",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        foto_packing2();
                                      },
                                      child: Card(
                                          child: file_packing2 == null
                                              ? Container(
                                                  child: Icon(
                                                    Icons.camera_enhance,
                                                    size: 150,
                                                  ),
                                                )
                                              : Image.file(
                                                  Io.File(file_packing2!.path),
                                                  height: 200,
                                                )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: (() async {
                                          if (packing1 == null) {
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //   content: Text(
                                            //       "Foto Packing 1 Tidak Boleh Kosong!"),
                                            //   duration: const Duration(seconds: 2),
                                            // ));

                                            dialog(
                                                "Foto Packing 1 Tidak Boleh Kosong!");
                                          } else if (packing2 == null) {
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //   content: Text(
                                            //       "Foto Packing 2 Tidak Boleh Kosong!"),
                                            //   duration: const Duration(seconds: 2),
                                            // ));
                                            dialog(
                                                "Foto Packing 2 Tidak Boleh Kosong!");
                                          } else {
                                            var timezone =
                                                DateTime.now().timeZoneName;
                                            Io.File photofile1 =
                                                Io.File(packing1!.path);
                                            Io.File photofile2 =
                                                Io.File(packing2!.path);

                                            bottomSheetKirim(
                                                widget.session.toString(),
                                                photofile1,
                                                photofile2,
                                                timezone.toString(),
                                                packingList[index]['sn']
                                                    .toString(),
                                                packingList[index]['id_box']
                                                    .toString());
                                          }
                                        }),
                                        child: Text("Submit"),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
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

  void bottomSheetKirim(String session, Io.File foto1, Io.File foto2,
      String timezone, String sn, String id_box) {
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
                      Text("Apa Anda Ingin Melakukan Submit Packing?"),
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
                                  await ServicesPacking.insert_packing(
                                      session.toString(),
                                      foto1,
                                      foto2,
                                      timezone.toString(),
                                      sn.toString(),
                                      id_box.toString());

                              if (result?.statuscode == "200") {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => ListPackingPage(
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
