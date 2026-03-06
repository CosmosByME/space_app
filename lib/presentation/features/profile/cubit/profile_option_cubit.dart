import 'package:bloc/bloc.dart';

class ProfileOptionCubit extends Cubit<int> {
  ProfileOptionCubit() : super(0);

  void changeOption(int newIndex) {
    emit(newIndex);
  }
}
