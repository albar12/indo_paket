import 'dart:convert';
import 'dart:io' as Io;

import 'package:dio/dio.dart';
import 'package:indo_paket/login/data_ws.dart';

class ServicesPacking {
  static Future<DataWs?> insert_packing(String session, Io.File foto_packing1,
      Io.File foto_packing2, String timezone, String sn, String id_box) async {
    final bytes1 = Io.File(foto_packing1.path).readAsBytesSync();
    String image_encode1 = base64Encode(bytes1);

    final bytes2 = Io.File(foto_packing2.path).readAsBytesSync();
    String image_encode2 = base64Encode(bytes2);

    FormData formData = FormData.fromMap({
      "session": session.toString(),
      "foto_packing": image_encode1,
      "foto_awb": image_encode2,
      "timezone": timezone.toString(),
      "sn": sn.toString(),
      "id_box": id_box.toString()
      // fileName
    });
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_packing",
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

  static Future<DataWs?> getListPacking(String session) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_packing",
          data: jsonEncode({'session': session}),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Barer dfd",
            "access-control-allow-headers": "*"
          }));
      print(response.data['ErrorMessage']);
      if (response.statusCode == 200) {
        // print(response.data['data']);
        // print(response.data['data'].contains("1"));
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

  static Future<DataWs?> cekTid(String session, String tid) async {
    try {
      var response = await Dio()
          .post("https://indopaket.jtracker.id/api_mobile/api_mobile/cek_tid",
              data: jsonEncode({'session': session, 'tid': tid}),
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
