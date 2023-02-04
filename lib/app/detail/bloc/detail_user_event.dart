part of 'detail_user_bloc.dart';

@immutable
abstract class DetailUserEvent {}

class EditUser extends DetailUserEvent {}

class UpdateUser extends DetailUserEvent {
  final User user;
  UpdateUser(this.user);
}
