import '../../app/extentions.dart';
import '../responses/response.dart';

import '../../domain/model/model.dart';

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(
        id:this?.id?.orEmpty()?? EMPTY,
        fullname:this?.fullname?.orEmpty() ??EMPTY,
        username:this?.username?.orEmpty() ??EMPTY,
        email: this?.email?.orEmpty() ??EMPTY,
        profileImage:this?.profileImage?.orEmpty() ??EMPTY,
        isActive:this?.isActive?.orFalse() ??FALSE,
        deviceToken:this?.deviceToken?.orEmpty() ??EMPTY,
        currentLocation: this?.currentLocation?.orEmptyMap() ??EMPTY_MAP,
        createdAt: this?.createdAt?.orEmpty() ??EMPTY
    );
  }
}


extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.accessToken,this?.refreshToken, this?.user?.toDomain());
  }
}

extension CarResponseMapper on CarResponse? {
  Car toDomain() {
    return Car(
        id:this?.id?.orEmpty()?? EMPTY,
        code :this?.code?.orEmpty() ??EMPTY,
        password:this?.password?.orEmpty() ??EMPTY,
        carType:this?.carType?.orEmpty() ??EMPTY,
        isActive:this?.isActive?.orFalse() ??FALSE,
        admin:this?.admin.toDomain(),
        users:this?.users?.map((user) => user.toDomain()).toList(),
        firmware:this?.firmware?.orEmptyMap() ??EMPTY_MAP,
        currentSpeed:this?.currentSpeed?.orZero() ??ZERO,
        defaultSpeed:this?.defaultSpeed?.orZero() ??ZERO,
        carLocation:this?.carLocation?.orEmptyMap() ??EMPTY_MAP,
        createdAt:this?.createdAt?.orEmpty() ??EMPTY,
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

