import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:indo_paket/login/data_ws.dart';

class ServiceLogout {
  static Future<DataWs?> logout(String session) async {
    try {
      var response = await Dio().post(
        "https://indopaket.jtracker.id/api_mobile/api_mobile/list_packing",
        data: jsonEncode({'session': session}),
      );

      print(response.statusCode);
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
}
