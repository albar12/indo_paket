import 'dart:convert';
import 'dart:io' as Io;

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indo_paket/login/data_ws.dart';
import 'package:http/http.dart' as http;

class ServicesProduksi {
  static Future<DataWs?> sendproduksi(String session, String sn_mesin,
      Io.File foto_struk, String timezone) async {
    final bytes1 = Io.File(foto_struk.path).readAsBytesSync();
    String image_encode1 = base64Encode(bytes1);

    // formdata
    String fileName = foto_struk.path.split('/').last;
    FormData formData = FormData.fromMap({
      "session": session.toString(),
      "sn_mesin": sn_mesin.toString(),
      "foto_struk": image_encode1,
      "timezone": timezone.toString()
    });

    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_produksi",
          data: formData,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(response.data['ErrorMessage']);
      if (response.statusCode == 200) {
        return DataWs(
            statuscode: response.data['ErrorCode'],
            errormsg: response.data['ErrorMessage']);
      }
      return null;
    } on DioError catch (e) {
      if (e.response?.statusCode == 500) {}
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  static Future<DataWs?> uploadImage({required Io.File file}) async {
    var _uri =
        "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_produksi";
    print(file);
    try {
      http.MultipartRequest request = new http.MultipartRequest(
          "POST",
          Uri.parse(
              "https://indopaket.jtracker.id/api_mobile/api_mobile/insert_produksi"));
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromString('file_name', file.path);
      request.files.add(multipartFile);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<dynamic>?> listProduksi(String session) async {
    try {
      var response = await Dio().post(
          "https://indopaket.jtracker.id/api_mobile/api_mobile/list_produksi",
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
}
