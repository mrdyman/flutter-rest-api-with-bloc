import 'package:context_holder/context_holder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_idstar/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:technical_test_idstar/app/dashboard/dashboard_screen.dart';

import '../../../models/user.dart';
import '../../../services/dio_client.dart';

part 'detail_user_event.dart';
part 'detail_user_state.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  BuildContext context = ContextHolder.currentContext;
  DetailUserBloc() : super(DetailUserInitial()) {
    on<EditUser>((event, emit) {
      emit(EditingUser());
    });

    on<UpdateUser>((event, emit) async {
      await updateUser(user: event.user);
    });

    on<StoreUser>((event, emit) async {
      await createUser(user: event.user);
    });

    on<DeleteUser>((event, emit) async {
      await deleteUser(userId: event.userId);
    });
  }

  Future<void> createUser({required User user}) async {
    try {
      User? response = await DioClient().createUser(
          data: User(
        id: 0,
        name: user.name,
        email: user.email,
        gender: user.gender,
        status: user.status,
      ));
      if (response != null && context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider<DashboardBloc>(
                      create: (context) => DashboardBloc(),
                      child: const DashboardScreen(),
                    )));
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      return;
    }
  }

  Future<void> updateUser({required User user}) async {
    try {
      User? response = await DioClient().updateUser(
          data: User(
        id: user.id,
        name: user.name,
        email: user.email,
        gender: user.gender,
        status: user.status,
      ));
      if (response != null && context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider<DashboardBloc>(
                      create: (context) => DashboardBloc(),
                      child: const DashboardScreen(),
                    )));
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      return;
    }
  }

  Future<void> deleteUser({required int userId}) async {
    try {
      bool response = await DioClient().deleteUser(id: userId);
      if (response && context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider<DashboardBloc>(
                      create: (context) => DashboardBloc(),
                      child: const DashboardScreen(),
                    )));
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      return;
    }
  }
}
