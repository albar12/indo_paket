import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:indo_paket/login/data_ws.dart';

class ServicesUnpacking {
  static Future<List<dynamic>?> getListUnpacking(String session) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_unpacking",
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

  static Future<DataWs?> sendunpacking(
      String session,
      String sn_mesin,
      String sn_provider,
      String sn_psam,
      String timezone,
      String catatan,
      String sn_psam2) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_unpacking",
          data: jsonEncode({
            'session': session.toString(),
            // 'session': null,
            'sn_mesin': sn_mesin.toString(),
            'sn_provider': sn_provider.toString(),
            'sn_psam': sn_psam.toString(),
            'timezone': timezone.toString(),
            'catatan': catatan.toString(),
            'sn_psam2': sn_psam2.toString(),
          }),
          options: Options(headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Barer dfd",
            "access-control-allow-headers": "*"
          }));
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
      // throw Exception(e.toString());
    }
  }
}
