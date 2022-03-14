import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  DioHelper(bool useAuth) {
    if (!useAuth)
      initDioWithoutAuth();
    else
      initDioWithAuth();
  }

  initDioWithAuth() {
    dio = Dio(BaseOptions(
      baseUrl: 'BASE_URL',
      receiveDataWhenStatusError: true,
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      contentType: 'application/json',
      headers: {
        'Content-Type': 'application/json',
        // 'Accept': '*/*',
        // 'Accept-Language': TranslateLang.langApi(),
        // 'Authorization': 'Bearer ' + CacheHelper.getToken()
      },
    ));
  }

  initDioWithoutAuth() {
    dio = Dio(BaseOptions(
      // baseUrl: BASE_URL,
      receiveDataWhenStatusError: true,
      followRedirects: false,
      receiveTimeout: 60 * 1000,
      connectTimeout: 60 * 1000,
      validateStatus: (status) {
        return status! < 500;
      },
      // contentType: 'application/json',
      headers: {
        'Content-Type': 'application/json',
        // 'Accept-Language': TranslateLang.langApi(),
      },
    ));
  }

  Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    // dio.options.headers={};
    return await dio.get(url, queryParameters: query);
  }

  Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return dio.post(
      url,
      data: data,
    );
  }



  Future<Response> postForm(
      {required String url, required FormData data}) async {
    return dio.post(url,
        data: data,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
        }));
  }

  Future<Response> putForm(
      {required String url, required FormData data}) async {
    return dio.put(url,
        data: data,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
        }));
  }

  Future<Response> putData(
      {required String url,
          Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    return dio.put(url, data: data, queryParameters: query);
  }

  Future<Response> deleteData(
      {required String url,
         Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    return dio.delete(url, data: data, queryParameters: query);
  }

  Future<Response> deleteDataDynamic(
      {required String url, dynamic data, Map<String, dynamic>? query}) async {
    return dio.delete(
      url,
      data: data,
      queryParameters: query,
    );
  }
}
