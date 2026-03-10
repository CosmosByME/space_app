import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:space_app/data/services/auth_service.dart';
import 'package:space_app/data/services/token_service.dart';
import 'package:space_app/domain/models/user_model.dart';
import 'package:space_app/domain/repository/user_repository_impl.dart';
import 'package:space_app/presentation/features/auth/login/login_page.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  Future<void> getUser() async {
    emit(UserState(state: StateEnum.loading));
    final uid = await TokenService.readToken();
    try {
      final user = await UserRepositoryImpl().loadUser(uid);
      emit(UserState(state: StateEnum.success, user: user!));
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(UserState(state: StateEnum.error, error: e));
    }
  }

  void updateProfile(UserModel user) async {
    await UserRepositoryImpl().updateUser(user);
    await getUser();
  }

  Future<void> logOutUser(BuildContext context) async {
    try {
      await AuthService.logOut();
      emit(UserState(state: StateEnum.initial));
    } catch (error) {
      debugPrint(error.toString());
      emit(UserState(state: StateEnum.error, error: error as Exception));
    } finally {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    }
  }
}
