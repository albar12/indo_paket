import 'dart:convert';
import 'dart:io' as Io;

import 'package:dio/dio.dart';
import 'package:indo_paket/login/data_ws.dart';

class ServicesPackingQc {
  static Future<DataWs?> getListPackingQc(
      String session, String sn_mesin) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_packing_qc",
          data: jsonEncode({'session': session, 'sn_mesin': sn_mesin}),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Barer dfd",
            "access-control-allow-headers": "*"
          }));
      print(response.data['ErrorMessage']);
      if (response.statusCode == 200) {
        print(response.data['data']);
        return DataWs(
            statuscode: response.data['ErrorCode'],
            errormsg: response.data['ErrorMessage'],
            data: response.data['data']);
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DataWs?> getListKelengkapan(String session) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_kelengkapan",
          data: jsonEncode({'session': session}),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Barer dfd",
            "access-control-allow-headers": "*"
          }));
      print(response.data['ErrorMessage']);
      if (response.statusCode == 200) {
        print(response.data['data']);
        return DataWs(
            statuscode: response.data['ErrorCode'],
            errormsg: response.data['ErrorMessage'],
            data: response.data['data']);
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DataWs?> insertPackingQc(
      String session,
      String sn_mesin,
      String id_box,
      String id_produk,
      String foto_struk_qc,
      String foto_tes1_qc,
      String foto_tes2_qc,
      String foto_tes3_qc,
      String foto_tes4_qc,
      String foto_tes5_qc,
      String timezone,
      String catatan_foto_struk,
      String catatan_foto_tes1,
      String catatan_foto_tes2,
      String catatan_foto_tes3,
      String catatan_foto_tes4,
      String catatan_foto_tes5,
      Io.File foto_kelengkapan,
      String cek_kelengkapan,
      String catatan_foto_kelengkapan) async {
    final bytes1 = Io.File(foto_kelengkapan.path).readAsBytesSync();
    String image_kelengkapan = base64Encode(bytes1);
    try {
      FormData formData = FormData.fromMap({
        'session': session,
        // 'session': null,
        'sn_mesin': sn_mesin,
        'id_box': id_box,
        'id_produk': id_produk,
        'foto_struk_qc': foto_struk_qc,
        'foto_tes1_qc': foto_tes1_qc,
        'foto_tes2_qc': foto_tes2_qc,
        'foto_tes3_qc': foto_tes3_qc,
        'foto_tes4_qc': foto_tes4_qc,
        'foto_tes5_qc': foto_tes5_qc,
        'timezone': timezone,
        'catatan_foto_struk': catatan_foto_struk,
        'catatan_foto_tes1': catatan_foto_tes1,
        'catatan_foto_tes2': catatan_foto_tes2,
        'catatan_foto_tes3': catatan_foto_tes3,
        'catatan_foto_tes4': catatan_foto_tes4,
        'catatan_foto_tes5': catatan_foto_tes5,
        'foto_kelengkapan': image_kelengkapan,
        'cek_kelengkapan': cek_kelengkapan,
        'catatan_foto_kelengkapan': catatan_foto_kelengkapan
      });
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_packing_qc",
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return DataWs(
            statuscode: response.data['ErrorCode'],
            errormsg: response.data['ErrorMessage']);
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DataWs?> getListQc(String session) async {
    try {
      var response = await Dio()
          .post("https://indopaket.jtracker.id/api_mobile/api_mobile/list_qc",
              data: jsonEncode({'session': session}),
              options: Options(headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Barer dfd",
                "access-control-allow-headers": "*"
              }));
      print(response.data['ErrorMessage']);
      if (response.statusCode == 200) {
        print(response.data['data']);
        return DataWs(
            statuscode: response.data['ErrorCode'],
            errormsg: response.data['ErrorMessage'],
            data: response.data['data']);
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
