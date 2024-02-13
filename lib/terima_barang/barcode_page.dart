import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:indo_paket/packing_qc/packing_qc_page.dart';
import 'package:indo_paket/produksi/produksi_page.dart';
import 'package:indo_paket/terima_barang/tambah_barang_page.dart';
import 'package:indo_paket/test_transaksi/test_transaksi_page.dart';
import 'package:indo_paket/unpacking/tambah_unpacking_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../terima_tarikan/tambah_barang_tarikan.dart';

class BCPage extends StatefulWidget {
  final String? session;
  final String? produk;
  final String? namaBox;
  final String? idBox;
  final String? type;
  final String? sub_type;
  final String? sn_mesin;
  final String? sn_provider;
  final String? sn_psam;
  final String? sn_psam2;
  final String? tid_lama;

  const BCPage({
    super.key,
    this.session,
    this.produk,
    this.namaBox,
    this.idBox,
    this.type,
    this.sn_mesin,
    this.sn_provider,
    this.sn_psam,
    this.sub_type,
    this.tid_lama,
    this.sn_psam2,
  });

  @override
  State<BCPage> createState() => _BCPageState();
}

class _BCPageState extends State<BCPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'BARCODE');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  void resume() async {
    await controller?.resumeCamera();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resume();
  }

  @override
  // void reassemble() {
  //   super.reassemble();
  //   print(Platform.isAndroid);
  //   if (Platform.isAndroid) {
  //     controller!.resumeCamera();
  //   }
  //   controller!.pauseCamera();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.100
        : 600.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 5,
          borderWidth: 2,
          // cutOutSize: scanArea
          cutOutHeight: 75,
          cutOutWidth: 300),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      if (widget.type == 'unpacking') {
        if (widget.sub_type == 'sn_mesin') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (ctx) => TambahUnpackingPage(
                        session: widget.session.toString(),
                        sn_mesin: scanData.code.toString(),
                        sn_provider: widget.sn_provider.toString(),
                        sn_psam: widget.sn_psam.toString(),
                        sn_psam2: widget.sn_psam2.toString(),
                      )),
              (route) => false);
        } else if (widget.sub_type == 'sn_provider') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (ctx) => TambahUnpackingPage(
                        session: widget.session.toString(),
                        sn_mesin: widget.sn_mesin.toString(),
                        sn_provider: scanData.code.toString(),
                        sn_psam: widget.sn_psam.toString(),
                        sn_psam2: widget.sn_psam2.toString(),
                      )),
              (route) => false);
        } else if (widget.sub_type == 'sn_psam') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (ctx) => TambahUnpackingPage(
                        session: widget.session.toString(),
                        sn_mesin: widget.sn_mesin.toString(),
                        sn_provider: widget.sn_provider.toString(),
                        sn_psam: scanData.code.toString(),
                        sn_psam2: widget.sn_psam2.toString(),
                      )),
              (route) => false);
        } else if (widget.sub_type == 'sn_psam2') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (ctx) => TambahUnpackingPage(
                        session: widget.session.toString(),
                        sn_mesin: widget.sn_mesin.toString(),
                        sn_provider: widget.sn_provider.toString(),
                        sn_psam: widget.sn_psam.toString(),
                        sn_psam2: scanData.code.toString(),
                      )),
              (route) => false);
        }
      } else if (widget.type == 'produksi') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (ctx) => ProduksiPage(
                      session: widget.session,
                      sn_mesin: scanData.code.toString(),
                    )),
            (route) => false);
      } else if (widget.type == 'test_transaksi') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (ctx) => TestTransaksiPage(
                      session: widget.session,
                      sn_mesin: scanData.code.toString(),
                    )),
            (route) => false);
      } else if (widget.type == 'packing_qc') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (ctx) => PackingQcPage(
                      session: widget.session,
                      sn_mesin: scanData.code.toString(),
                    )),
            (route) => false);
      } else if (widget.type == 'tambah_tarikan') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (ctx) => TambahBarangTarikanPage(
                      session: widget.session,
                      sn_mesin: scanData.code.toString(),
                      tid_lama: widget.tid_lama,
                      id_box: widget.idBox,
                      nama_box: widget.namaBox,
                    )),
            (route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (ctx) => TambahBarangPage(
                      session: widget.session,
                      scan: scanData.code.toString(),
                      produk: widget.produk,
                      nama_box: widget.namaBox,
                      id_box: widget.idBox,
                    )),
            (route) => false);
      }
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
