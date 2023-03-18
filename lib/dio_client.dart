import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'cache.dart';

class DioClient {
  late Dio dio;
  CacheOptions cacheOptions;
  DioClient(this.cacheOptions) {
    dio = Dio();
    print("insed  DioClient >>>>>>>");
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }
  Future<Map<String, dynamic>> getResponse() async {
    Response response =
        await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    print("insed get response method");
    print(response.data);
    Map<String, dynamic> map = response.data;
    return map;
  }
}
