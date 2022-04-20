class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class Customer{
  String id;
  String name;
  int numOfNotification;
  Customer(this.id,this.name,this.numOfNotification);
}

class Contacts{
  String email;
  String phoneNumber;
  String link;
  Contacts(this.email,this.link,this.phoneNumber);
}

class Authentication{
  Customer customer;
  Contacts contacts;
  Authentication(this.customer,this.contacts);
}

class DeviceInfo{
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name,this.identifier,this.version);
}