import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:indo_paket/data/data_tambah_barang.dart';

class ServicesTambahBarang {
  static Future<List<dynamic>?> drop_produk(String session) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/dropdown_produk",
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

  static Future<DataTambahBarang?> add_barang(String session, String produk,
      String sn, String id_box, String timezone) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_barang",
          data: jsonEncode({
            'session': session.toString(),
            'id_produk': produk.toString(),
            'sn': sn.toString(),
            'id_box': id_box.toString(),
            'timezone': timezone.toString()
          }),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Barer dfd",
            "access-control-allow-headers": "*"
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        return DataTambahBarang(
          statuscode: response.statusCode.toString(),
          errormsg: response.data['ErrorMessage'],
        );
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {}
  }

  static Future<List<dynamic>?> list_barang(
      String session, String id_box) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_insert_barang",
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
