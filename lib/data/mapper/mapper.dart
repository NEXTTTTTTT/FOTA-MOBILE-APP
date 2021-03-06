import '../../app/extentions.dart';
import '../responses/response.dart';

import '../../domain/model/model.dart';

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
        id: this?.id?.orEmpty() ?? EMPTY,
        fullname: this?.fullname?.orEmpty() ?? EMPTY,
        username: this?.username?.orEmpty() ?? EMPTY,
        email: this?.email?.orEmpty() ?? EMPTY,
        profileImage: this?.profileImage?.orEmpty() ?? EMPTY,
        isActive: this?.isActive?.orFalse() ?? FALSE,
        deviceToken: this?.deviceToken?.orEmpty() ?? EMPTY,
        currentLocation: this?.currentLocation?.orEmptyMap() ?? EMPTY_MAP,
        createdAt: this?.createdAt?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.accessToken, this?.refreshToken, this?.user?.toDomain());
  }
}

extension CarResponseMapper on CarResponse? {
  Car toDomain() {
    return Car(
      id: this?.id?.orEmpty() ?? EMPTY,
      code: this?.code?.orEmpty() ?? EMPTY,
      password: this?.password?.orEmpty() ?? EMPTY,
      carType: this?.carType?.orEmpty() ?? EMPTY,
      isMotorOn: this?.isMotorOn.orFalse() ?? FALSE,
      isAcOn: this?.isACOn?.orFalse() ?? FALSE,
      isBagOn: this?.isBagOn?.orFalse() ?? FALSE,
      isDoorLocked: this?.isDoorLocked?.orFalse() ?? FALSE,
      temperature: this?.temperature?.orZero() ?? ZERO,
      admin: this?.admin.toDomain(),
      users: this?.users?.map((user) => user.toDomain()).toList(),
      firmware: this?.firmware?.orEmpty() ?? EMPTY,
      currentSpeed: this?.currentSpeed?.orZero() ?? ZERO,
      defaultSpeed: this?.defaultSpeed?.orZero() ?? ZERO,
      carLocation: this?.carLocation?.orEmpty() ?? EMPTY,
      createdAt: this?.createdAt?.orEmpty() ?? EMPTY,
    );
  }
}

extension MyCarsResponseMapper on MyCarsResponse? {
  List<Car> toDomain() {
    return this!.myCars!.map((car) => car.toDomain()).toList();
  }
}

extension UserDataResponseMapper on UserDataResponse? {
  User toDomain() {
    return this!.user.toDomain();
  }
}

extension BaseResponseMapper on BaseResponse? {
  Success toDomain() {
    return Success(this?.msg.orEmpty() ?? EMPTY);
  }
}

extension UserDataListResponseMapper on UserDataListResponse? {
  List<User> toDomain() {
    return this?.users?.map((user) => user.toDomain()).toList() ?? [];
  }
}

extension NotfiyResponseMapper on NotifyResponse? {
  Notify toDomain() {
    return Notify(
        id: this?.id?.orEmpty() ?? EMPTY,
        user: this?.user.toDomain(),
        action: this?.action.orEmpty()?? EMPTY,
        isRead: this?.isRead?.orFalse() ?? FALSE,
        car: this?.car?.toDomain(),
        createdAt: this?.createdAt.orEmpty() ?? EMPTY);
  }
}

extension NotifyListResponseMapper on NotifyListResponse? {
  List<Notify> toDomain() {
    return this?.notifies?.map((notify) => notify.toDomain()).toList() ?? [];
  }
}
