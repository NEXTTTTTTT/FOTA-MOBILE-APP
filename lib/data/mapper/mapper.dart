import 'package:fota_mobile_app/app/extentions.dart';
import 'package:fota_mobile_app/data/responses/response.dart';

import '../../domain/model/model.dart';

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
        this!.id!.orEmpty(),
        this!.fullname!.orEmpty(),
        this!.username!.orEmpty(),
        this!.email!.orEmpty(),
        this!.profileImage!.orEmpty(),
        this!.isActive!.orFalse(),
        this!.deviceToken!.orEmpty(),
        this!.currentLocation!.orEmptyMap(),
        this!.createdAt!.orEmpty()
    );
  }
}


extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this!.accessToken!, this!.user.toDomain());
  }
}
