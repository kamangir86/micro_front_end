import 'package:core/core.dart';

class AuthEvent extends CoreEvent {
  final String userId;

  AuthEvent(this.userId);
}

class UserLoginEvent extends CoreEvent {
  final String userId;

  UserLoginEvent(this.userId);
}

class UserLogoutEvent extends CoreEvent {}