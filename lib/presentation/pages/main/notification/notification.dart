import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fota_mobile_app/domain/model/model.dart';
import 'package:fota_mobile_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:fota_mobile_app/presentation/resources/color_manager.dart';
import 'package:fota_mobile_app/presentation/resources/font_manager.dart';
import 'package:fota_mobile_app/presentation/resources/style_manager.dart';
import 'package:fota_mobile_app/presentation/resources/values_manager.dart';

import '../../../bussiness_logic/notify_cubit/notify_cubit.dart';
import '../../../resources/strings_manager.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotifyCubit, NotifyState>(
      listener: (context, state) {},
      builder: (context, state) {
        var notifyCubit = BlocProvider.of<NotifyCubit>(context);
        return notifyCubit.notifys.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) =>
                    getNotifyItem(notifyCubit.notifys[index]))
            : StateRenderer(
                stateRendererType: StateRendererType.EMPTY_SCREEN_STATE,
                retryActionFunction: null,message: 'No Notifications yet',);
      },
    );
  }

  getNotifyItem(Notify notify) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(AppMargin.m16)),
      child: Row(children: [
        CircleAvatar(),
        Column(
          children: [
            Text(
              notify.user!.fullname,
              style: getRegularStyle(
                  color: ColorManager.darkGrey, fontSize: FontSizeManager.s16),
            ),
            Text(
              notify.text,
              style: getRegularStyle(
                  color: ColorManager.darkGrey, fontSize: FontSizeManager.s13),
            ),
          ],
        )
      ]),
    );
  }
}
