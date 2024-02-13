import 'dart:convert';
import 'dart:io' as Io;

import 'package:dio/dio.dart';
import 'package:indo_paket/login/data_ws.dart';

class ServicesTesTransaksi {
  static Future<DataWs?> insert_test_transaksi(
      String session,
      String sn_mesin,
      Io.File foto_tes1,
      Io.File foto_tes2,
      Io.File foto_tes3,
      Io.File foto_tes4,
      Io.File foto_tes5,
      String timezone) async {
    final bytes1 = Io.File(foto_tes1.path).readAsBytesSync();
    String image_encode1 = base64Encode(bytes1);

    final bytes2 = Io.File(foto_tes2.path).readAsBytesSync();
    String image_encode2 = base64Encode(bytes2);

    final bytes3 = Io.File(foto_tes3.path).readAsBytesSync();
    String image_encode3 = base64Encode(bytes3);

    final bytes4 = Io.File(foto_tes4.path).readAsBytesSync();
    String image_encode4 = base64Encode(bytes4);

    final bytes5 = Io.File(foto_tes5.path).readAsBytesSync();
    String image_encode5 = base64Encode(bytes5);
    FormData formData = FormData.fromMap({
      "session": session.toString(),
      // "session": null,
      "sn_mesin": sn_mesin.toString(),
      "foto_test1": image_encode1,
      "foto_test2": image_encode2,
      "foto_test3": image_encode3,
      "foto_test4": image_encode4,
      "foto_test5": image_encode5,
      "timezone": timezone.toString()
      // fileName
    });
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_test_transaksi",
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      if (response.statusCode == 200) {
        print(response.statusCode);
        return DataWs(
          statuscode: response.data['ErrorCode'],
          errormsg: response.data['ErrorMessage'],
        );
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<dynamic>?> listTransaksi(String session) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_test_transaksi",
          data: jsonEncode({'session': session}),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Barer dfd",
            "access-control-allow-headers": "*"
          }));
      // print(response.statusCode);
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
