part of 'detail_user_bloc.dart';

@immutable
abstract class DetailUserState {
  final nameTEC = TextEditingController();
  final emailTEC = TextEditingController();
  final genderTEC = TextEditingController();
  final statusTEC = TextEditingController();
}

class DetailUserInitial extends DetailUserState {}

class EditingUser extends DetailUserState {}
