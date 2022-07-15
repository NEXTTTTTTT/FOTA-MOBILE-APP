import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fota_mobile_app/app/functions.dart';
import 'package:fota_mobile_app/presentation/bussiness_logic/search_cubit/search_cubit.dart';
import 'package:fota_mobile_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:fota_mobile_app/presentation/resources/color_manager.dart';
import 'package:fota_mobile_app/presentation/resources/font_manager.dart';
import 'package:fota_mobile_app/presentation/resources/style_manager.dart';
import 'dart:math' as math;
import 'package:fota_mobile_app/presentation/resources/values_manager.dart';

import '../../../domain/model/model.dart';
import '../../bussiness_logic/car_cubit/car_cubit.dart';

class SearchUsersView extends StatefulWidget {
  const SearchUsersView({Key? key}) : super(key: key);

  @override
  State<SearchUsersView> createState() => _SearchUsersViewState();
}

class _SearchUsersViewState extends State<SearchUsersView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchCubit = BlocProvider.of<SearchCubit>(context);
        var carCubit = BlocProvider.of<CarCubit>(context);
        Widget getSearchAppBar() {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorManager.lightGrey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppMargin.m16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(CupertinoIcons.arrow_left),
                    color: ColorManager.black,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      controller: _searchController,
                      style: getRegularStyle(
                          color: ColorManager.darkGrey,
                          fontSize: FontSizeManager.s18),
                      decoration: InputDecoration(
                        hintText: 'Search users',
                        hintStyle: getRegularStyle(
                            color: ColorManager.lightGrey,
                            fontSize: FontSizeManager.s18),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        searchCubit.searchUsers(_searchController.text);
                      },
                      icon: Icon(CupertinoIcons.search,
                          color: ColorManager.black))
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark),
            backgroundColor: ColorManager.white,
            title: getSearchAppBar(),
          ),
          body: state is SearchLoadingState
              ? StateRenderer(
                  stateRendererType:
                      StateRendererType.FULL_SCREEN_LOADING_STATE,
                  retryActionFunction: null,
                  message: "Searching ..")
              : searchCubit.filteredUsers.isNotEmpty
                  ? getContent(context, searchCubit.filteredUsers)
                  : StateRenderer(
                      stateRendererType: StateRendererType.EMPTY_SCREEN_STATE,
                      retryActionFunction: null,
                      message: "No users found"),
        );
      },
    );
  }

  getContent(context, List<User> users) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p5,
              ),
              child: getUserItem(
                users[index],
                context,
              ),
            ));
  }

  Widget getUserItem(
    User user,
    context,
  ) {
    return BlocBuilder<CarCubit, CarState>(builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
            color: ColorManager.lightGrey.withOpacity(0.0),
            borderRadius: BorderRadius.circular(AppMargin.m16)),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                  child: Text(
                    getChars(user.fullname),
                    style: getRegularStyle(
                        color: ColorManager.white,
                        fontSize: FontSizeManager.s14),
                  ),
                  backgroundColor:
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                  radius: AppSize.s20),
              const SizedBox(
                width: AppSize.s12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullname,
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                        color: ColorManager.darkGrey,
                        fontSize: FontSizeManager.s16),
                  ),
                  Text(
                    user.username,
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                        color: ColorManager.grey,
                        fontSize: FontSizeManager.s14),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    // share car with this user
                    BlocProvider.of<CarCubit>(context).shareCar(user.id,
                        BlocProvider.of<CarCubit>(context).selectedCarCode!);

                    // remove user from search list
                    BlocProvider.of<SearchCubit>(context)
                        .removeUserFromSearch(user);

                    //show toast
                    showShortToast('${user.fullname.toLowerCase()} added successfully!');
                  },
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(ColorManager.primary)),
                  child: Text(
                    'Add',
                    style: getRegularStyle(
                        color: ColorManager.white,
                        fontSize: FontSizeManager.s14),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
