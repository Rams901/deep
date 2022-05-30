import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deeptherapy/bloc/authentication_bloc.dart';
import 'package:deeptherapy/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> 
{
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* //this 
  {
    if (event is LoginButtonPressed) {
      
      yield LoginInitial();
      try {
        final user = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      }
      catch (error) {
        yield LoginFaliure(error: error.toString());
      }

    }
    // if (event is SignUpButtonPressed) 
    // {
      
    //   yield LoginInitial();
      
    //   //try using this, else just like question api

    //   try {

        

    //     authenticationBloc.add(LoggedIn(user: new_user));
    //     yield LoginInitial();

    //   }
    //   catch (error) 
    //   {
    //     yield LoginFaliure(error: error.toString());
    //   }
    // }
  }
}