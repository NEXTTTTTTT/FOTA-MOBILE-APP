import 'package:fota_mobile_app/app/extentions.dart';
import 'package:fota_mobile_app/data/responses/response.dart';

import '../../domain/model/model.dart';

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
        this?.id?.orEmpty()?? EMPTY,
        this?.fullname?.orEmpty() ??EMPTY,
        this?.username?.orEmpty() ??EMPTY,
        this?.email?.orEmpty() ??EMPTY,
        this?.profileImage?.orEmpty() ??EMPTY,
        this?.isActive?.orFalse() ??FALSE,
        this?.deviceToken?.orEmpty() ??EMPTY,
        this?.currentLocation?.orEmptyMap() ??EMPTY_MAP,
        this?.createdAt?.orEmpty() ??EMPTY
    );
  }
}


extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.accessToken, this?.user?.toDomain());
  }
}
