import '../network/error_handler.dart';

import '../responses/response.dart';

const String MY_DATA_KEY = "MY_DATA_KEY_";
const String MY_CARS_DATA_KEY = "MY_CARS_DATA_KEY_";
const int CACHE_MY_CARS_DATA_INTERVAL =10 * 60 * 1000;
const int CACHE_MY_DATA_INTERVAL = 5 * 60 * 1000;

abstract class LocalDataSource {
  void clearCache();
  void clearFromCache(String key);
  Future<MyCarsResponse> getMyCars(String id);
  Future<void> saveMyCarsToCache(MyCarsResponse myCarsResponse, String id);

  Future<UserDataResponse> getUserData(String id);
  Future<void> saveUserDataToCache(
      UserDataResponse userDataResponse, String id);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<MyCarsResponse> getMyCars(String id) async {
    CachedItem? cachedItem = cacheMap[MY_CARS_DATA_KEY + id];

    if (cachedItem != null && cachedItem.isValid(CACHE_MY_CARS_DATA_INTERVAL)) {
      // get data from cached
      return cachedItem.data;
    } else {
      // throw error
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<UserDataResponse> getUserData(String id) async {
    CachedItem? cachedItem = cacheMap[MY_DATA_KEY + id];

    if (cachedItem != null && cachedItem.isValid(CACHE_MY_DATA_INTERVAL)) {
      // get data from cached
      return cachedItem.data;
    } else {
      // throw error
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveMyCarsToCache(
      MyCarsResponse myCarsResponse, String id) async {
    cacheMap[MY_CARS_DATA_KEY + id] = CachedItem(myCarsResponse);
  }

  @override
  Future<void> saveUserDataToCache(
      UserDataResponse userDataResponse, String id) async {
    cacheMap[MY_DATA_KEY + id] = CachedItem(userDataResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void clearFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtention on CachedItem {
  bool isValid(int expirationTime) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = (currentTime - expirationTime) < cacheTime;
    return isCacheValid;
  }
}
