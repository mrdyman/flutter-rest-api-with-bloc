import 'dart:developer';

import 'package:context_holder/context_holder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_idstar/services/dio_client.dart';

import '../../../models/user.dart';
import '../../detail/bloc/detail_user_bloc.dart';
import '../../detail/detail_user_screen.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    BuildContext context = ContextHolder.currentContext;
    on<GetUsers>((event, emit) async {
      emit(DashboardLoading());
      List<User>? user = await getUsers();
      emit(DashboardLoaded(users: user));
    });

    on<CreateUser>((event, emit) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider<DetailUserBloc>(
                  create: (context) => DetailUserBloc(),
                  child: const DetailUserScreen(isCreate: true),
                )),
      );
    });

    on<DetailUser>((event, emit) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider<DetailUserBloc>(
                  create: (context) => DetailUserBloc(),
                  child: DetailUserScreen(user: event.user, isCreate: false),
                )),
      );
    });

    on<SearchUser>((event, emit) {
      emit(DashboardLoading());
      List<User>? result = searchUser(event.user, event.keyword);
      emit(DashboardLoaded(users: result));
    });
  }

  Future<List<User>?> getUsers() async {
    List<User>? users;
    try {
      List<User>? response = await DioClient().getUsers();
      users = response;
    } on DioError catch (e) {
      debugPrint(e.message);
    }
    return users;
  }

  searchUser(List<User> data, String keyword) {
    return data.where((e) => e.name.contains(keyword)).toList();
  }
}
