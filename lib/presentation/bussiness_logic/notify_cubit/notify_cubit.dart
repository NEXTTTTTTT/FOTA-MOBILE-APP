import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/model/model.dart';

part 'notify_state.dart';

class NotifyCubit extends Cubit<NotifyState> {
  NotifyCubit() : super(NotifyInitial());

  List<Notify> notifys=[];
}
