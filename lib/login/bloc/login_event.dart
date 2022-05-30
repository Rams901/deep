part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({
    required this.username,
    required this.password
  });

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'LoginButtonPressed { username: $username, password: $password }';
}

class SignUpButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final String title;
  final String country;
  final String phone;

  const SignUpButtonPressed({
    required this.username,
    required this.password,
    required this.title,
  required this.country,
  required this.phone
  });

  @override
  List<Object> get props => [username, password, title, country, phone];

  @override
  String toString() => 'SignUpButtonPressed { username: $username, password: $password, title: $title, country:$country, phone: $phone }';
}
// (title, username, password, country, phone, )