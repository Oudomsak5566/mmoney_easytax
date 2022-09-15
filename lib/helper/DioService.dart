import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

Dio dio = Dio();
// const baseUrl = "https://uattaxris.mmoney.la/";
const baseUrl = "https://taxris.mmoney.la/";
const url = "https://graph.mmoney.la/";

class DioService {
  static Future createDio({var body, String? path}) async {
    try {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final req = body;

      print(req);
      var response = await dio.post<Map>(
        baseUrl + path!,
        data: req,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      var data = response.data;

      print(data);
      return data;
    } catch (e) {
      print(e);
    }
  }

  static Future createDioToken(
      {var body, String? path, required String token}) async {
    try {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      final req = body;
      print('createDioToken ===> ${req}');

      var response = await dio.post(
        baseUrl + path!,
        data: req,
        options: Options(
          headers: {"x-access-token": token},
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      var data = response.data;

      print('response ===> ${data}');
      return data;
    } catch (e) {
      print(e);
    }
  }

  // static Future createHttp({var body, String? path}) async {
  //   try {
  //     final ioc = new HttpClient();
  //     ioc.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //     final http = new IOClient(ioc);
  //     Map<String, String> headers = {
  //       // "Content-Type": "application/json",
  //       "Accept": "application/json"
  //     };
  //     http.post(Uri.parse("https://graph.mmoney.la/easyTax_list"),
  //         headers: headers, body: {"TIN": "244285788-000"}).then((response) {
  //       print("Reponse status : ${response.statusCode}");
  //       print("Response body : ${response.body}");
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
