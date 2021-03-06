import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  // car details page index
  int carsDetailsPageIndex = 0;

  changeIndex(index) {
    carsDetailsPageIndex = index;
    emit(CarsDetailsPageIndexChangedSuccessState(index));
  }
}
