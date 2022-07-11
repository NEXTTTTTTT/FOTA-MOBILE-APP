import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/map_cubit/map_cubit.dart';
import 'package:get_it/get_it.dart';
import '../domain/usecase/refresh_token_usecase.dart';
import '../presentation/bussiness_logic/app_cubit/app_cubit.dart';
import '../presentation/bussiness_logic/cars_bloc/cars_bloc.dart';
import '../presentation/bussiness_logic/position_bloc/position_bloc.dart';
import '../presentation/bussiness_logic/user_bloc/user_bloc.dart';
import '../presentation/pages/login/login_view_model.dart';

import '../presentation/pages/register/register_view_model.dart';
import '../presentation/pages/splash/splash_view_model.dart';
import 'app_prefs.dart';
import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../domain/repository/repository.dart';
import '../data/repository/repository_implementer.dart';
import '../domain/usecase/get_my_cars_usecase.dart';
import '../domain/usecase/get_user_data_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/register_usecase.dart';

import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // app prefs
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(DataConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImplementer(instance(), instance(), instance()));

  // user bloc
  instance.registerLazySingleton<UserBloc>(() => UserBloc(instance()));

  // cars bloc
  instance.registerLazySingleton<CarsBloc>(
      () => CarsBloc(instance(), instance(), ));

  // position bloc
  instance.registerLazySingleton<PositionBloc>(() => PositionBloc(instance(),instance()));

  //map cubit
  instance.registerLazySingleton<MapCubit>(() => MapCubit());

  // app cubit
  instance.registerLazySingleton<AppCubit>(() => AppCubit());

  // getMyCarsUseCase
  instance.registerLazySingleton<GetMyCarsUseCase>(
      () => GetMyCarsUseCase(instance()));

  // getUserDataUseCase
  instance.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(instance()));
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(
          instance(),
        ));
  }
}

Future<void> initRegisterModule() async {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(
          instance(),
        ));
  }
}

Future<void> initSplashModule() async {
  // refresh token usecase
  instance.registerFactory<RefreshTokenUseCase>(() => RefreshTokenUseCase(
        instance(),
      ));
  // splashViewModel
  instance.registerFactory<SplashViewModel>(() => SplashViewModel(
        instance(),
        instance(),
      ));
}

resetAllModules() {
  instance.reset(dispose: false);
  initAppModule();
  initSplashModule();
  initLoginModule();
  initRegisterModule();
}
