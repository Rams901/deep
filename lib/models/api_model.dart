class UserLogin {
  String username;
  String password;

  UserLogin({required this.username,required this.password});

  Map <String, dynamic> toDatabaseJson(String is_doctor) => {
    "username": this.username,
    "password": this.password,
    'is_doctor': is_doctor
  };
}
class DocSignUp {
  String username;
  String password;
  String title;
  String country;
  String phone;
  String email;
  DocSignUp({required this.username,required this.password,required this.email,required this.title ,required this.country ,required this.phone });

  Map <String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "password": this.password,
    "title":this.title,
    "country":this.country,
    "phone":this.phone,
    "email":this.email
  };
}
class Token{
  String token;

  Token({required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token']
    );
  }
}

