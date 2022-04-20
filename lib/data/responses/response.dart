import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;

}

@JsonSerializable()
class CustomerResponse{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotification;
  
  CustomerResponse(this.id,this.name,this.numOfNotification);
  // from json
  factory CustomerResponse.fromJson(Map<String,dynamic> json)=> _$CustomerResponseFromJson(json);
  // to json
  Map<String,dynamic> toJson() =>_$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse{
  @JsonKey(name: "phoneNumber")
  String? phoneNumber;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "email")
  String? email;
  
  ContactsResponse(this.phoneNumber,this.link,this.email);
  // from json
  factory ContactsResponse.fromJson(Map<String,dynamic> json)=> _$ContactsResponseFromJson(json);
  // to json
  Map<String,dynamic> toJson() =>_$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;

  AuthenticationResponse(this.customer,this.contacts);
  // from json
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=> _$AuthenticationResponseFromJson(json);
  // to json
  Map<String,dynamic> toJson() =>_$AuthenticationResponseToJson(this);
}