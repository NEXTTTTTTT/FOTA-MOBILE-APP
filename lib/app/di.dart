import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:fota_mobile_app/domain/usecase/connect_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/remove_user_away_my_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/search_user_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/share_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/unshare_car_usecase.dart';
import 'package:fota_mobile_app/domain/usecase/update_user_usecase.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/map_cubit/map_cubit.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/search_cubit/search_cubit.dart';
import 'package:get_it/get_it.dart';
import '../domain/usecase/disconnect_car_usecase.dart';
import '../presentation/bussiness_logic/app_cubit/app_cubit.dart';
import '../presentation/bussiness_logic/car_cubit/car_cubit.dart';
import '../presentation/bussiness_logic/notify_cubit/notify_cubit.dart';
import '../presentation/bussiness_logic/position_cubit/position_cubit.dart';
import '../presentation/bussiness_logic/user_cubit/user_cubit.dart';
import '../presentation/pages/login/login_view_model.dart';

import '../presentation/pages/register/register_view_model.dart';
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

  //* BLOCS
  //*1 user bloc
  instance.registerLazySingleton<UserCubit>(
      () => UserCubit(instance(), instance()));
  //*2 cars bloc
  instance.registerLazySingleton<CarCubit>(() => CarCubit(
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
        instance(),
      ));
  //*3 position bloc
  instance.registerLazySingleton<PositionCubit>(() => PositionCubit(
        instance(),
      ));
  //*4 map cubit
  instance.registerLazySingleton<MapCubit>(() => MapCubit());
  //*5 app cubit
  instance.registerLazySingleton<AppCubit>(() => AppCubit());
  //*6 notify cubit
  instance.registerLazySingleton<NotifyCubit>(() => NotifyCubit());
  //*7 search cubit
  instance.registerLazySingleton<SearchCubit>(
      () => SearchCubit(instance(), instance(), ));
//********************************** */

//* USECASES
  // getMyCarsUseCase
  instance.registerLazySingleton<GetMyCarsUseCase>(
      () => GetMyCarsUseCase(instance()));

  // getUserDataUseCase
  instance.registerLazySingleton<GetUserDataUseCase>(
      () => GetUserDataUseCase(instance()));
  // connectCarUseCase
  instance.registerLazySingleton<ConnectCarUseCase>(
      () => ConnectCarUseCase(instance()));
  // disconnectCarUseCase
  instance.registerLazySingleton<DisConnectCarUseCase>(
      () => DisConnectCarUseCase(instance()));
  // removeUserAwayCarUseCase
  instance.registerLazySingleton<RemoveUserAwayMyCarUseCase>(
      () => RemoveUserAwayMyCarUseCase(instance()));

  // SearchUserUseCase
  instance.registerLazySingleton<SearchUserDataUseCase>(
      () => SearchUserDataUseCase(instance()));

  // shareCarUseCase
  instance.registerLazySingleton<ShareCarUseCase>(
      () => ShareCarUseCase(instance()));

  // unshareCarUseCase
  instance.registerLazySingleton<UnShareCarUseCase>(
      () => UnShareCarUseCase(instance()));

  // updateUserUseCase
  instance.registerLazySingleton<UpdateUserDataUseCase>(
      () => UpdateUserDataUseCase(instance()));
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

resetAllModules() {
  instance.reset(dispose: false);
  initAppModule();
  initLoginModule();
  initRegisterModule();
}
