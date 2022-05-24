import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fota_mobile_app/app/app_prefs.dart';
import 'package:fota_mobile_app/app/di.dart';

import '../domain/model/model.dart';
import 'constants.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "unknown";
  String identifier = "unknown";
  String version = "unknown";
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // return android device info
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + " " + build.model;
      identifier = build.androidId;
      version = build.version.codename;
    } else if (Platform.isIOS) {
      // return ios device info
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name + " " + build.model;
      identifier = build.identifierForVendor;
      version = build.systemVersion;
    }
  } on PlatformException {
    // return default data here
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}



bool isIamAdminOfTheCar(Car car) {
  return car.admin!.id == Constants.myId;
}

dismissDialog(BuildContext context) {
  if (_isThereCurrentDialogShowing(context)) {
    // todo: check if rootNavigator is needed
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

_isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)!.isCurrent != true;
