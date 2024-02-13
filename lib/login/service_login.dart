import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:indo_paket/login/data_login.dart';

class ServiceLogin {
  static Future<DataLogin?> login(String username, String password) async {
    print(username);
    print(password);
    try {
      var response = await Dio()
          .post("https://indopaket.jtracker.id/api_mobile/api_mobile/login",
              data: jsonEncode({'email': username, 'password': password}),
              options: Options(headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Barer dfd",
                "access-control-allow-headers": "*"
              }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return DataLogin(
          statusCode: response.data['ErrorCode'],
          session: response.data['session'],
          name: response.data['name'],
          nik: response.data['nik'],
          ktp: response.data['ktp'],
          phone: response.data['phone'],
          workingStartDate: response.data['workingStartDate'],
          workingEndDate: response.data['workingEndDate'],
          letterOfAssignmentMTI: response.data['letterOfAssignmentMTI'],
          letterOfAssignmentPCS: response.data['letterOfAssignmentPCS'],
          errorMsg: response.data['ErrorMessage'],
        );
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {
        print(e.response?.statusMessage);
        return DataLogin(
          statusCode: e.response?.statusCode.toString(),
          errorMsg: e.response?.statusMessage,
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
