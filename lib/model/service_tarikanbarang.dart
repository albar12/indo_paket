import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:indo_paket/data/data_lisbox.dart';

import '../data/data_tambah_barang.dart';

class ServicesTarikanBarang {
  static Future<List<dynamic>?> listBox(String session) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_box_tarikan",
          data: jsonEncode({'session': session}),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Barer dfd",
            "access-control-allow-headers": "*"
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data['data']);
        return response.data['data'];
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<DataListBox?> createBox(
      String session, String timezone, String nama_box) async {
    print(session);
    print(timezone);
    print(nama_box);
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/add_box_tarikan",
          data: jsonEncode({
            'session': session.toString(),
            'timezone': timezone.toString(),
            'nama_box': nama_box.toString()
          }));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return DataListBox(
            statuscode: response.statusCode.toString(),
            errormsg: response.data['ErrorMessage']);
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {}
  }

  static Future<DataTambahBarang?> tambah_tarikan(String session,
      String timezone, String sn, String tid_lama, String id_box) async {
    print(session);
    print(timezone);
    print(sn);
    print(tid_lama);
    print(id_box);
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_barang_tarikan",
          data: jsonEncode({
            'session': session.toString(),
            'timezone': timezone.toString(),
            'sn': sn.toString(),
            'tid_lama': tid_lama.toString(),
            'id_box': id_box.toString()
          }));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return DataTambahBarang(
            statuscode: response.statusCode.toString(),
            errormsg: response.data['ErrorMessage']);
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {}
  }

  static Future<List<dynamic>?> list_tarikan(
      String session, String id_box) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_insert_barang_tarikan",
          data: jsonEncode({'session': session, 'id_box': id_box}),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Barer dfd",
            "access-control-allow-headers": "*"
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data['data']);
        return response.data['data'];
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
