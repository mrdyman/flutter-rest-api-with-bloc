import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_user_event.dart';
part 'detail_user_state.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  DetailUserBloc() : super(DetailUserInitial()) {
    on<DetailUserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  // bool validate() {
  //   if (!state.formKey.currentState!.validate()) {
  //     return false;
  //   }
  //   return true;
  // }

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
}
