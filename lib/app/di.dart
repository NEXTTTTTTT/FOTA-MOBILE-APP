import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fota_mobile_app/app/app_prefs.dart';
import 'package:fota_mobile_app/data/data_source/remote_data_source.dart';
import 'package:fota_mobile_app/data/network/app_api.dart';
import 'package:fota_mobile_app/data/network/dio_factory.dart';
import 'package:fota_mobile_app/data/network/network_info.dart';
import 'package:fota_mobile_app/domain/repository/repository.dart';
import 'package:fota_mobile_app/domain/repository/repository_implementer.dart';
import 'package:fota_mobile_app/domain/usecase/login_usecase.dart';
import 'package:fota_mobile_app/presentation/login/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule()async{
  final sharedPrefs = await SharedPreferences.getInstance();
  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // app prefs
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementer(DataConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client
  final dio =await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(instance()));

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImplementer(instance(), instance()));
}

Future<void>initLoginModule()async{
  if(!GetIt.I.isRegistered<LoginUseCase>())
    {
      instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
      instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
    }

}