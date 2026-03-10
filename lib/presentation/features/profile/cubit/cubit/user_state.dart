part of 'user_cubit.dart';

enum StateEnum { initial, loading, success, error }

class UserState {
  final StateEnum state;
  final UserModel? user;
  final Exception? error;

  UserState({this.state = StateEnum.initial, this.user, this.error});
}
