import 'package:context_holder/context_holder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

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
  }

  // Future<User?> createUser({required User user}) async {
  //   if (!validate()) {
  //     return null;
  //   }
  //   try {
  //     User? response = await DioClient().createUser(
  //         data: User(
  //       id: 0,
  //       name: user.name,
  //       email: user.email,
  //       gender: user.gender,
  //       status: user.status,
  //     ));
  //     return response;
  //   } on DioError catch (e) {
  //     debugPrint(e.message);
  //     return null;
  //   }
  // }

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
        Navigator.pop(context);
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("e.message"),
      ));
      return;
    }
  }
}
