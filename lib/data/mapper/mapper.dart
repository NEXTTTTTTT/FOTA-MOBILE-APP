

import 'package:fota_mobile_app/app/extentions.dart';
import 'package:fota_mobile_app/data/responses/response.dart';

import '../../domain/model/model.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(this!.id!.orEmpty(), this!.name!.orEmpty(),
        this!.numOfNotification!.orZero());
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this!.email!.orEmpty(), this!.link!.orEmpty(),
        this!.phoneNumber!.orEmpty());
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?{
  Authentication toDomain(){
    return Authentication(this!.customer.toDomain(), this!.contacts.toDomain());
  }
}