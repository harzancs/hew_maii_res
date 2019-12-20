class SreachLogin {
  String user;
  String password;

  SreachLogin({this.user,this.password});

  factory SreachLogin.fromJson(Map<String,dynamic> json) {
    return SreachLogin(
      user: json['username'] as String,
      password: json['password'] as String
    );
  }
}