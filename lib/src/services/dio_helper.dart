import 'package:dio/dio.dart';


class DioHelper {
  static Dio dio = Dio(
    BaseOptions(
        baseUrl: "https://accept.paymob.com/api",
        headers: {
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true),
  );


  static Future<Response> postData(
      {required String url, Map<String, dynamic>? data}) async {
    return await dio.post(url, data: data);
  }
}