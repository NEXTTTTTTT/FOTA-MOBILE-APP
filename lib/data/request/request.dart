class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String fullname;
  String username;
  String email;
  String password;
  RegisterRequest(this.fullname,this.username,this.email, this.password);
}
