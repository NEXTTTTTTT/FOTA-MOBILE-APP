import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fota_mobile_app/presentation/pages/car_details/cars_details_view_model.dart';
import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../domain/model/model.dart';

import '../../common/state_renderer/state_renderer_impl.dart';
import 'package:geolocator/geolocator.dart';


import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';


class CarDetailsView extends StatefulWidget {
  const CarDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  State<CarDetailsView> createState() => _CarDetailsViewState();
}

class _CarDetailsViewState extends State<CarDetailsView> {
  final CarDetailsViewModel _viewModel = instance<CarDetailsViewModel>();

  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  _bind() {
    _viewModel.start();
    _viewModel.getMyCars();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                      context, _getContentWidget(), _viewModel.start) !=
                  null
              ? _getContentWidget()
              : Container();
        });
  }

  _getContentWidget() {
    return StreamBuilder<List<Car>>(
        stream: _viewModel.outputMyCarsList,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Scaffold(
                  backgroundColor: ColorManager.background,
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(CupertinoIcons.arrow_left),
                      color: ColorManager.grey,
                    ),
                    centerTitle: true,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarIconBrightness: Brightness.dark),
                    backgroundColor: ColorManager.white,
                    elevation: 0,
                    title: Row(children: [
                      Text(
                        snapshot.data![_currentIndex].carType +
                            ' ' +
                            snapshot.data![_currentIndex].code,
                        style: getRegularStyle(
                            color: ColorManager.grey,
                            fontSize: FontSizeManager.s24),
                      ),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      CircleAvatar(
                          maxRadius: AppSize.s4,
                          backgroundColor:
                              snapshot.data![_currentIndex].isActive
                                  ? ColorManager.green
                                  : ColorManager.red),
                    ]),
                  ),
                  body: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });

                        Constants.defaultCar = snapshot.data![index];
                      },
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        List<Car> cars =
                            _getSortedCarsListWithDefaultFirst(snapshot.data);
                        return CarPage(
                          myCar: cars[index],
                        );
                      }))
              : Container();
        });
  }

  List<Car> _getSortedCarsListWithDefaultFirst(List<Car>? cars) {
    List<Car> newCarsList;
    if (cars!.first.id == Constants.defaultCar.id) {
      return cars;
    } else {
      newCarsList = [Constants.defaultCar];
      for (var car in cars) {
        if (car.id != Constants.defaultCar.id) {
          newCarsList.add(car);
        }
      }
    }
    return newCarsList;
  }
}

class CarPage extends StatelessWidget {
  final Car myCar;

  const CarPage({Key? key, required this.myCar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(children: [
        Expanded(
          flex: 1,
          child: SizedBox(
              width: double.infinity, child: _getAdminWidget(myCar.admin!)),
        ),
        _spaceHeight(),
        Expanded(
            flex: 2,
            child: SizedBox(
                width: double.infinity,
                child: PlaceDistanceWidget(
                  myCar: myCar,
                ))),
        _spaceHeight(),
        Expanded(
            flex: 1,
            child: SizedBox(
              child: _getRemoteControlWidget(myCar),
              width: double.infinity,
            )),
        _spaceHeight(),
        Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: SizedBox(
                        width: double.infinity, child: _getSpeedWidget(myCar))),
                _spaceWidth(),
                Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: _getTempWidget(myCar),
                      width: double.infinity,
                    )),
              ],
            )),
        _spaceHeight(),
        Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: _getUsersWidget(myCar),
            )),
      ]),
    );
  }

  _getAdminWidget(User user) {
    return CustomContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TODO: change profile pic
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/564x/1b/e1/3f/1be13feb311ab005aca97ddf6e34df4a.jpg'),
            radius: AppSize.s25,
          ),
          const SizedBox(
            width: AppSize.s14,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullname,
                style: getRegularStyle(
                    color: ColorManager.darkGrey,
                    fontSize: FontSizeManager.s18),
              ),
              Text(
                user.username,
                style: getRegularStyle(
                    color: ColorManager.grey, fontSize: FontSizeManager.s14),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p5),
            child: Text('Adminstrator',
                style: getRegularStyle(
                    color: ColorManager.primary,
                    fontSize: FontSizeManager.s14)),
          )
        ],
      ),
    );
  }

  _getRemoteControlWidget(Car myCar) {
    return CustomContainer(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s18),
                )),
                backgroundColor: MaterialStateProperty.all(ColorManager.red)),
            onPressed: () {
              print('force stop');
            },
            child: Text('Force Stop',
                style: getRegularStyle(color: ColorManager.white))),
        CircleAvatar(
          backgroundColor: ColorManager.background,
          child: IconButton(
            onPressed: () {
              print('center lock');
            },
            icon: const Icon(
              CupertinoIcons.lock_fill,
            ),
            color: ColorManager.darkGrey,
          ),
        ),
        CircleAvatar(
          backgroundColor: ColorManager.background,
          child: IconButton(
            onPressed: () {
              print('center lock');
            },
            icon: const Icon(
              CupertinoIcons.lock_open_fill,
            ),
            color: ColorManager.darkGrey,
          ),
        ),
        CircleAvatar(
          backgroundColor: ColorManager.background,
          child: IconButton(
            onPressed: () {
              print('center lock');
            },
            icon: const Icon(
              CupertinoIcons.car_detailed,
            ),
            color: ColorManager.darkGrey,
          ),
        ),
      ],
    ));
  }

  _getSpeedWidget(Car myCar) {
    return CustomContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.gauge,
                size: AppSize.s50,
                color: ColorManager.grey,
              ),
              const SizedBox(
                height: AppSize.s5,
              ),
              Text(
                '110 KM/H',
                style: getBoldStyle(
                    color: ColorManager.darkGrey,
                    fontSize: FontSizeManager.s25),
              ),
              Text(
                'Maximum speed is 200',
                maxLines: 2,
                style: getBoldStyle(
                    color: ColorManager.grey, fontSize: FontSizeManager.s15),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppSize.s14,
        ),
        TextButton(
            onPressed: () {
              print('change max speed');
            },
            child: const Text('change default\nmaximum speed'))
      ],
    ));
  }

  _getTempWidget(Car myCar) {
    return CustomContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.cloud_sun,
                size: AppSize.s50,
                color: ColorManager.grey,
              ),
              const SizedBox(
                height: AppSize.s4,
              ),
              Text(
                '22 C',
                style: getBoldStyle(
                    color: ColorManager.darkGrey,
                    fontSize: FontSizeManager.s25),
              ),
              const SizedBox(
                height: AppSize.s4,
              ),
              Text(
                'Air Conditioner',
                style: getBoldStyle(
                    color: ColorManager.grey, fontSize: FontSizeManager.s15),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppSize.s4,
        ),
        CupertinoSwitch(
            value: true,
            onChanged: (value) {
              print('air conditioner');
            })
      ],
    ));
  }

  _getUsersWidget(Car myCar) {
    return CustomContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Users',
              style: getBoldStyle(
                  color: ColorManager.grey, fontSize: FontSizeManager.s18),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  print('modify users');
                },
                child: const Text('Modify users'))
          ],
        ),
        Row(
          children: [5, 5, 6, 7]
              .map((userImage) => const Padding(
                    padding: EdgeInsets.only(right: AppPadding.p3),
                    child: CircleAvatar(
                      radius: AppSize.s16,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/564x/1b/e1/3f/1be13feb311ab005aca97ddf6e34df4a.jpg'),
                    ),
                  ))
              .toList(),
        ),
      ],
    ));
  }

  _spaceHeight() {
    return const SizedBox(
      height: AppSize.s8,
    );
  }

  _spaceWidth() {
    return const SizedBox(
      width: AppSize.s8,
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s14),
        color: ColorManager.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: child,
      ),
    );
  }
}

class PlaceDistanceWidget extends StatefulWidget {
  final Car myCar;
  const PlaceDistanceWidget({Key? key, required this.myCar}) : super(key: key);

  @override
  State<PlaceDistanceWidget> createState() => _PlaceDistanceWidgetState();
}

class _PlaceDistanceWidgetState extends State<PlaceDistanceWidget> {
  @override
  void initState() {
    _getDistance();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? placemark;
  int? distance;

  
   
  _getDistance() async {
     double carLat = double.parse(widget.myCar.carLocation['lat']);
     double carLng = double.parse(widget.myCar.carLocation['lng']);
    var position = await Geolocator().getCurrentPosition();
    var placemarks = await Geolocator()
        .placemarkFromCoordinates(carLat,carLng);
    var distanceBetweenMeAndCar = await Geolocator().distanceBetween(
        position.latitude,
        position.longitude,
        carLat,
        carLng);

    setState(() {
      placemark = placemarks[0].country +
          ' - ' +
          placemarks[0].administrativeArea +
          ' - ' +
          placemarks[0].subAdministrativeArea +
          ' - ' +
          placemarks[0].locality;
      distance = distanceBetweenMeAndCar ~/ 1000; // KM
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: CustomContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(placemark ?? '-',
                  maxLines: 3,
                  style: getRegularStyle(
                      color: ColorManager.darkGrey,
                      fontSize: FontSizeManager.s20)),
              Text('${distance ?? '-'} KM to get this car',
                  style: getRegularStyle(
                      color: ColorManager.grey, fontSize: FontSizeManager.s15)),
            ],
          ),
        ),
      ),
    );
  }
}
