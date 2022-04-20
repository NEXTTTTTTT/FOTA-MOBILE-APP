abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{
  // shared variables and functions that will be through any view model.
}

abstract class BaseViewModelInputs{
  void start(); // will be called while init of view model.
  void dispose(); // will be called when view model dies.
}

abstract class BaseViewModelOutputs{

}

