part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class GetUsers extends DashboardEvent {}

class CreateUser extends DashboardEvent {}

class DetailUser extends DashboardEvent {}
