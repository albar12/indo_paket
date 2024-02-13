import 'dart:ffi';
import 'dart:ui';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indo_paket/dashboard/dashboard_page.dart';
import 'package:indo_paket/data/data_packingqc.dart';
import 'package:indo_paket/login/data_ws.dart';
import 'package:indo_paket/model/service_packingqc.dart';
import 'package:indo_paket/packing/list_packing_page.dart';
import 'package:indo_paket/packing/packing_page.dart';
import 'package:indo_paket/packing_qc/list_packing_qc.dart';
import 'package:indo_paket/produksi/list_produksi_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/barcode_page.dart';
import 'package:indo_paket/terima_barang/terima_barang_page.dart';
import 'package:indo_paket/test_transaksi/list_testransaksi_page.dart';
import 'package:indo_paket/test_transaksi/test_transaksi_page.dart';
import 'package:indo_paket/unpacking/unpacking_page.dart';

import '../home/home_page.dart';
import '../terima_tarikan/terima_tarikan.dart';

// enum SingingCharacter { '1', '2' }

class PackingQcPage extends StatefulWidget {
  final String? session;
  final String? sn_mesin;

  const PackingQcPage({
    super.key,
    this.session,
    this.sn_mesin,
  });

  @override
  State<PackingQcPage> createState() => _PackingQcPageState();
}

class _PackingQcPageState extends State<PackingQcPage> {
  TextEditingController sn = TextEditingController();
  TextEditingController no_box = TextEditingController();
  TextEditingController nm_produk = TextEditingController();
  TextEditingController create_adm = TextEditingController();
  TextEditingController datetime = TextEditingController();
  TextEditingController catatan_foto_struk = TextEditingController();
  TextEditingController catatan_foto_tes1 = TextEditingController();
  TextEditingController catatan_foto_tes2 = TextEditingController();
  TextEditingController catatan_foto_tes3 = TextEditingController();
  TextEditingController catatan_foto_tes4 = TextEditingController();
  TextEditingController catatan_foto_tes5 = TextEditingController();
  TextEditingController catatan_foto_kelengkapan = TextEditingController();

  Future? packingQcFuture;
  Future? kelengkapanFuture;
  List packingQcList = [];
  List kelengkapanList = [];
  List valueKelengkapan = [];

  String? foto_struk;
  String? foto_tes1;
  String? foto_tes2;
  String? foto_tes3;
  String? foto_tes4;
  String? foto_tes5;
  String? kelengkapan_foto;

  XFile? kelengkapan;
  Io.File? file_kelengkapan;

  final ImagePicker _picker = ImagePicker();

  void foto_kelengkapan() async {
    kelengkapan = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 15,
    );
    setState(() {
      file_kelengkapan = Io.File(kelengkapan!.path);
      kelengkapan_foto = '1';
    });
  }

  void getList(String session, String sn_mesin) async {
    packingQcFuture =
        ServicesPackingQc.getListPackingQc(session, sn_mesin).then((value) {
      print("list");
      print(value?.data?.length);
      if (value?.data?.length != 0 && value?.data?.length != null) {
        if (this.mounted) {
          setState(() {
            packingQcList = value!.data!;
            qc_visible = true;
          });
        }
      } else if (value?.statuscode == null) {
        setState(() {
          qc_visible = false;
        });
        dialog("Data Tidak Ditemukan Silahkan Cek Kembali Data Yang Diinput");
      } else {
        dialog(value?.errormsg);
      }
    });
  }

  void getKelengkapan(String session) async {
    kelengkapanFuture =
        ServicesPackingQc.getListKelengkapan(session).then((value) {
      print("kelengkapan");
      print(value?.data);

      if (value?.data != null) {
        if (this.mounted) {
          setState(() {
            kelengkapanList = value!.data!;
          });
        }
      }
    });
  }

  void ubah_sn(String snMesin) {
    if (this.mounted) {
      setState(() {
        sn.text = snMesin;
      });
    }
  }

  bool visible = true;
  bool qc_visible = false;
  bool isChecked = false;

  int _selectedIndex = 6;

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
                    builder: (ctx) => ListPackingQCPage(
                          session: widget.session,
                        )),
                (route) => false);
          },
        ),
        title: Text("Quality Control"),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
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
                            type: 'packing_qc',
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
                child: Visibility(
                    visible: visible,
                    child: ElevatedButton(
                      onPressed: (() {
                        print(sn.text);

                        if (sn.text.isNotEmpty) {
                          getList(
                              widget.session.toString(), sn.text.toString());
                          getKelengkapan(widget.session.toString());
                          // ubah_sn(widget.sn_mesin.toString());
                        } else {
                          dialog("Input Serial Number Terlebih Dahulu!");
                        }
                      }),
                      child: Text("Qc"),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: qc_visible,
                child: FutureBuilder(
                  future: packingQcFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          // scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: packingQcList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    text: "${packingQcList[index]['no_box']}",
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nama Produk',
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  controller: TextEditingController(
                                    text:
                                        "${packingQcList[index]['nm_produk']}",
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Foto Struk"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.network(
                                      "${packingQcList[index]['foto_struk']}"),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '1',
                                        groupValue: foto_struk,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_struk = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Tidak Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '2',
                                        groupValue: foto_struk,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_struk = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Catatan Foto Struk',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  controller: catatan_foto_struk,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Foto Test Transaksi 1"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.network(
                                      "${packingQcList[index]['foto_test1']}"),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '1',
                                        groupValue: foto_tes1,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes1 = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Tidak Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '2',
                                        groupValue: foto_tes1,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes1 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Catatan Foto Test Transaksi 1',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  controller: catatan_foto_tes1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Foto Test Transaksi 2"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.network(
                                      "${packingQcList[index]['foto_test2']}"),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '1',
                                        groupValue: foto_tes2,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes2 = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Tidak Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '2',
                                        groupValue: foto_tes2,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes2 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Catatan Foto Test Transaksi 2',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  controller: catatan_foto_tes2,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Foto Test Transaksi 3"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.network(
                                      "${packingQcList[index]['foto_test3']}"),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '1',
                                        groupValue: foto_tes3,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes3 = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Tidak Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '2',
                                        groupValue: foto_tes3,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes3 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Catatan Foto Test Transaksi 3',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  controller: catatan_foto_tes3,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Foto Test Transaksi 4"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.network(
                                      "${packingQcList[index]['foto_test4']}"),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '1',
                                        groupValue: foto_tes4,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes4 = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Tidak Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '2',
                                        groupValue: foto_tes4,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes4 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Catatan Foto Test Transaksi 4',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  controller: catatan_foto_tes4,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Foto Test Transaksi 5"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 300,
                                  width: 300,
                                  child: Image.network(
                                      "${packingQcList[index]['foto_test5']}"),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '1',
                                        groupValue: foto_tes5,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes5 = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: RadioListTile(
                                        title: Text(
                                          "Tidak Sesuai",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        value: '2',
                                        groupValue: foto_tes5,
                                        onChanged: (value) {
                                          setState(() {
                                            foto_tes5 = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Catatan Foto Test Transaksi 5',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  controller: catatan_foto_tes5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Foto Kelengkapan Paket"),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    foto_kelengkapan();
                                  },
                                  child: Center(
                                    child: Card(
                                        child: file_kelengkapan == null
                                            ? Container(
                                                child: Icon(
                                                  Icons.camera_enhance,
                                                  size: 150,
                                                ),
                                              )
                                            : Image.file(
                                                Io.File(file_kelengkapan!.path),
                                                height: 200,
                                              )),
                                  ),
                                ),
                                Column(
                                  children: [
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: kelengkapanList.length,
                                        itemBuilder: ((context, index) {
                                          return CheckboxListTile(
                                            title: Text(
                                                "${kelengkapanList[index]['name']}"),
                                            value: kelengkapanList[index]
                                                ['value'],
                                            onChanged: ((value) {
                                              setState(() {
                                                kelengkapanList[index]
                                                    ['value'] = value!;
                                                valueKelengkapan.add(
                                                    kelengkapanList[index]
                                                        ['ID']);
                                              });
                                            }),
                                          );
                                        }))
                                  ],
                                ),
                                TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'Catatan Foto Kelengkapan Isi Paket',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  controller: catatan_foto_kelengkapan,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Create Admin',
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  controller: TextEditingController(
                                    text:
                                        "${packingQcList[index]['create_adm']}",
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Create Date',
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  controller: TextEditingController(
                                    text: "${packingQcList[index]['datetime']}",
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: packingQcList.isEmpty == true
                                      ? Container()
                                      : ElevatedButton(
                                          onPressed: (() async {
                                            if (foto_struk == null ||
                                                foto_tes1 == null ||
                                                foto_tes2 == null ||
                                                foto_tes3 == null ||
                                                foto_tes4 == null ||
                                                foto_tes5 == null ||
                                                kelengkapan_foto == null) {
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(SnackBar(
                                              //   content: Text(
                                              //       "Semua Foto Wajib Dilakukan QC!"),
                                              //   duration:
                                              //       const Duration(seconds: 2),
                                              // ));
                                              dialog(
                                                  "Semua Foto Wajib Dilakukan QC!");
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    LinearProgressIndicator(),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ));
                                              var timezone =
                                                  DateTime.now().timeZoneName;
                                              DataPackingQc datax =
                                                  DataPackingQc();

                                              datax.session =
                                                  widget.session.toString();
                                              datax.sn_mesin =
                                                  sn.text.toString();
                                              datax.id_box =
                                                  packingQcList[index]['id_box']
                                                      .toString();
                                              datax.id_produk =
                                                  packingQcList[index]
                                                          ['id_produk']
                                                      .toString();
                                              datax.foto_struk_qc =
                                                  foto_struk.toString();
                                              datax.foto_tes1_qc =
                                                  foto_tes1.toString();
                                              datax.foto_tes2_qc =
                                                  foto_tes2.toString();
                                              datax.foto_tes3_qc =
                                                  foto_tes3.toString();
                                              datax.foto_tes4_qc =
                                                  foto_tes4.toString();
                                              datax.foto_tes5_qc =
                                                  foto_tes5.toString();
                                              datax.timezone =
                                                  timezone.toString();
                                              datax.catatan_foto_struk =
                                                  catatan_foto_struk.text
                                                      .toString();
                                              datax.catatan_foto_tes1 =
                                                  catatan_foto_tes1.text
                                                      .toString();
                                              datax.catatan_foto_tes2 =
                                                  catatan_foto_tes2.text
                                                      .toString();
                                              datax.catatan_foto_tes3 =
                                                  catatan_foto_tes3.text
                                                      .toLowerCase();
                                              datax.catatan_foto_tes4 =
                                                  catatan_foto_tes4.text
                                                      .toString();
                                              datax.catatan_foto_tes5 =
                                                  catatan_foto_tes5.text
                                                      .toString();

                                              Io.File photokelengkapan =
                                                  Io.File(kelengkapan!.path);

                                              datax.kelengkapan_foto =
                                                  photokelengkapan;

                                              datax.check_kelengkapan =
                                                  valueKelengkapan.join(",");

                                              datax.catatan_kelengkapan_foto =
                                                  catatan_foto_kelengkapan.text
                                                      .toString();

                                              bottomSheetKirim(datax);
                                            }
                                          }),
                                          child: Text("Submit"),
                                        ),
                                )
                              ],
                            );
                          });
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
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

  void bottomSheetKirim(DataPackingQc data) {
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
                      Text("Apa Anda Ingin Melakukan Submit QC?"),
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
                                  await ServicesPackingQc.insertPackingQc(
                                      data.session.toString(),
                                      data.sn_mesin.toString(),
                                      data.id_box.toString(),
                                      data.id_produk.toString(),
                                      data.foto_struk_qc.toString(),
                                      data.foto_tes1_qc.toString(),
                                      data.foto_tes2_qc.toString(),
                                      data.foto_tes3_qc.toString(),
                                      data.foto_tes4_qc.toString(),
                                      data.foto_tes5_qc.toString(),
                                      data.timezone.toString(),
                                      data.catatan_foto_struk.toString(),
                                      data.catatan_foto_tes1.toString(),
                                      data.catatan_foto_tes2.toString(),
                                      data.catatan_foto_tes3.toString(),
                                      data.catatan_foto_tes4.toString(),
                                      data.catatan_foto_tes5.toString(),
                                      data.kelengkapan_foto!,
                                      data.check_kelengkapan.toString(),
                                      data.catatan_kelengkapan_foto.toString());

                              print(result?.errormsg);

                              if (result?.statuscode == "200") {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => ListPackingQCPage(
                                              session: widget.session,
                                            )),
                                    (route) => true);
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
