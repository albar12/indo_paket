import 'dart:io' as Io;

class DataPackingQc {
  String? session;
  String? sn_mesin;
  String? id_box;
  String? id_produk;
  String? foto_struk_qc;
  String? foto_tes1_qc;
  String? foto_tes2_qc;
  String? foto_tes3_qc;
  String? foto_tes4_qc;
  String? foto_tes5_qc;
  String? timezone;
  String? catatan_foto_struk;
  String? catatan_foto_tes1;
  String? catatan_foto_tes2;
  String? catatan_foto_tes3;
  String? catatan_foto_tes4;
  String? catatan_foto_tes5;
  Io.File? kelengkapan_foto;
  String? check_kelengkapan;
  String? catatan_kelengkapan_foto;

  DataPackingQc({
    this.session,
    this.sn_mesin,
    this.id_box,
    this.id_produk,
    this.foto_struk_qc,
    this.foto_tes1_qc,
    this.foto_tes2_qc,
    this.foto_tes3_qc,
    this.foto_tes4_qc,
    this.foto_tes5_qc,
    this.timezone,
    this.catatan_foto_struk,
    this.catatan_foto_tes1,
    this.catatan_foto_tes2,
    this.catatan_foto_tes3,
    this.catatan_foto_tes4,
    this.catatan_foto_tes5,
    this.kelengkapan_foto,
    this.check_kelengkapan,
    this.catatan_kelengkapan_foto,
  });
}
