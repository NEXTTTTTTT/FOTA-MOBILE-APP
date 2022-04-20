import 'dart:async';

import 'package:fota_mobile_app/domain/model/model.dart';
import 'package:fota_mobile_app/presentation/base/base_view_model.dart';
import 'package:fota_mobile_app/presentation/resources/assets_manager.dart';
import 'package:fota_mobile_app/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getPageData();
    // send this page data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length-1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex == index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private functions
  List<SliderObject> _getPageData() {
    return [
      SliderObject(AppStrings.title1, AppStrings.subTitle1,
          AssetsManager.onBoardingLogo1),
      SliderObject(AppStrings.title2, AppStrings.subTitle2,
          AssetsManager.onBoardingLogo2),
      SliderObject(AppStrings.title3, AppStrings.subTitle3,
          AssetsManager.onBoardingLogo3),
      SliderObject(AppStrings.title4, AppStrings.subTitle4,
          AssetsManager.onBoardingLogo4),
    ];
  }

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// inputs means the order that our view model will receive from our view.
abstract class OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);

  Sink
      get inputSliderViewObject; // this is the way to add data to stream .. stream input
}

// outputs means the data or results that will be sent from our view model to our view.
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
