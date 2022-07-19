import '../network/error_handler.dart';

import '../responses/response.dart';

const String MY_DATA_KEY = "MY_DATA_KEY_";
const String MY_CARS_DATA_KEY = "MY_CARS_DATA_KEY_";
const String MY_NOTIFYS_DATA_KEY = "MY_NOTIFYS_DATA_KEY_";
const int CACHE_MY_CARS_DATA_INTERVAL =10 * 60 * 1000;
const int CACHE_MY_DATA_INTERVAL = 5 * 60 * 1000;

abstract class LocalDataSource {
  void clearCache();
  void clearFromCache(String key);

  Future<MyCarsResponse> getMyCars();
  Future<void> saveMyCarsToCache(MyCarsResponse myCarsResponse);

  Future<UserDataResponse> getUserData();
  Future<void> saveUserDataToCache(
      UserDataResponse userDataResponse,);

      Future<NotifyListResponse> getNotifys();
  Future<void> saveNotifys(NotifyListResponse notifyListResponse);

}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<MyCarsResponse> getMyCars() async {
    CachedItem? cachedItem = cacheMap[MY_CARS_DATA_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_MY_CARS_DATA_INTERVAL)) {
      // get data from cached
      return cachedItem.data;
    } else {
      // throw error
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<UserDataResponse> getUserData() async {
    CachedItem? cachedItem = cacheMap[MY_DATA_KEY];

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
      MyCarsResponse myCarsResponse,) async {
    cacheMap[MY_CARS_DATA_KEY] = CachedItem(myCarsResponse);
  }

  @override
  Future<void> saveUserDataToCache(
      UserDataResponse userDataResponse) async {
    cacheMap[MY_DATA_KEY ] = CachedItem(userDataResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void clearFromCache(String key) {
    cacheMap.remove(key);
  }
  
  @override
  Future<NotifyListResponse> getNotifys() {
     CachedItem? cachedItem = cacheMap[MY_NOTIFYS_DATA_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_MY_DATA_INTERVAL)) {
      // get data from cached
      return cachedItem.data;
    } else {
      // throw error
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }
  
  @override
  Future<void> saveNotifys(NotifyListResponse notifyListResponse)async {
    cacheMap[MY_NOTIFYS_DATA_KEY ] = CachedItem(notifyListResponse);
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
