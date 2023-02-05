part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class GetUsers extends DashboardEvent {}

class GetInfinityUsers extends DashboardEvent {
  final List<User>? users;
  GetInfinityUsers({this.users});
}

class CreateUser extends DashboardEvent {}

class DetailUser extends DashboardEvent {
  final User user;
  DetailUser(this.user);
}

class SearchUser extends DashboardEvent {
  final List<User> user;
  final String keyword;
  SearchUser(this.user, this.keyword);
}
