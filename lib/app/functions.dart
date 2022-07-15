import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_prefs.dart';
import 'di.dart';

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

setMyIdAsConst({required String id}) async {
  /// set id in constants
  Constants.myId = id;
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

bool isLocationValid(location) {
  return location != null && location['lat'] != null && location['lng'] != null;
}

String getChars(String name) {
  var names = name.split(' ');
  String chars = '';
  if (names.length == 3) {
    chars = names[0].substring(0, 1) + names[2].substring(0, 1);
  }
  else if (names.length == 2) {
    chars = names[0].substring(0, 1) + names[1].substring(0, 1);
  } else {
    chars = names[0].substring(0, 1);
  }
  return chars.toUpperCase();
}

void showShortToast(String msg) {
    Fluttertoast.showToast(
        msg:msg,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1);
  }