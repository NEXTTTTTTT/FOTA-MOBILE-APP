import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../domain/model/model.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import 'on_boarding_view_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _bind() {
    _viewModel.start();
    _appPreferences.setOnBoardingScreenViewed();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) => _getContent(snapshot.data));
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) => Container(
        color: ColorManager.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // left arrow
            Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(AssetsManager.leftArrow),
                ),
                onTap: () {
                  // go to previous page
                  _pageController.animateToPage(_viewModel.goPrevious(),
                      duration: AppDuration.d300, curve: Curves.bounceIn);
                },
              ),
            ),
            // circles
            Row(
              children: [
                for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: _getProperCircle(i, sliderViewObject.currentIndex),
                  )
              ],
            ),
            // right arrow
            Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(AssetsManager.rightArrow),
                ),
                onTap: () {
                  // go to next page
                  _pageController.animateToPage(_viewModel.goNext(),
                      duration: AppDuration.d300, curve: Curves.bounceIn);
                },
              ),
            ),
          ],
        ),
      );

  Widget _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return SvgPicture.asset(AssetsManager.solidCircle);
    } else {
      return SvgPicture.asset(AssetsManager.hollowCircle);
    }
  }

  Widget _getContent(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        body: PageView.builder(
          itemCount: sliderViewObject.numOfSlides,
          itemBuilder: (context, index) =>
              OnBoardingPage(sliderObject: sliderViewObject.sliderObject),
          controller: _pageController,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: Text(
                        AppStrings.skip,
                        style: Theme.of(context).textTheme.subtitle1,
                      ))),
              _getBottomSheetWidget(sliderViewObject)
            ],
          ),
        ),
      );
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject sliderObject;
  OnBoardingPage({Key? key, required this.sliderObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Center(
            child: SvgPicture.asset(
          sliderObject.image,
          height: AppSize.s250,
          allowDrawingOutsideViewBox: false,
          fit: BoxFit.cover,
        )),
      ],
    );
  }
}
