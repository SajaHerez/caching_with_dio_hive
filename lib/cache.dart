import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class Cache {
  static Future<String> _getCacheDirectory() async {
    final directory = await getTemporaryDirectory();
    print("insed  getCacheDirectory >>>>>>");
    print(directory.path);
    return directory.path;
  }

  static Future<HiveCacheStore> _getCacheStore() async {
    print("insed getCacheStore >>>>>>");
    String path = await _getCacheDirectory();
    final cacheStore = HiveCacheStore(
      path,
      hiveBoxName: "mmy_app",
    );
    return cacheStore;
  }

  static Future<CacheOptions> getCachOptions() async {
    print("insed getCachOptions >>>>>>");
    final cacheStore = await _getCacheStore();
    final customCacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      maxStale: const Duration(minutes: 7),
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) {
        return request.uri.toString();
      },
      allowPostMethod: false,
    );
    return customCacheOptions;
  }
}
