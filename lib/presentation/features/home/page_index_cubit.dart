import 'package:bloc/bloc.dart';

class PageIndexCubit extends Cubit<int> {
  PageIndexCubit() : super(0);
  void changeIndex(int index) => emit(index);
}
