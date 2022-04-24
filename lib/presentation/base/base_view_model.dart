import 'dart:async';

import 'package:fota_mobile_app/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and functions that will be through any view model.
  StreamController _inputStateStreamController = StreamController<FlowState>.broadcast();


  @override
  void dispose() {
    _inputStateStreamController.close();
  }
  @override
  Sink get inputState => _inputStateStreamController.sink;
  
  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);

}

abstract class BaseViewModelInputs {
  void start(); // will be called while init of view model.
  void dispose(); // will be called when view model dies.

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
