import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_idstar/app/dashboard/bloc/dashboard_bloc.dart';

import '../../models/user.dart';
import 'bloc/detail_user_bloc.dart';

class DetailUserScreen extends StatelessWidget {
  final User? user;
  final bool isCreate;
  const DetailUserScreen({super.key, this.user, required this.isCreate});

  @override
  Widget build(BuildContext context) {
    DetailUserBloc bloc = BlocProvider.of<DetailUserBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<DetailUserBloc, DetailUserState>(
          builder: (context, state) {
            bloc.state.nameTEC.text = user?.name ?? "";
            bloc.state.emailTEC.text = user?.email ?? "";
            bloc.state.genderTEC.text = user?.gender ?? "";
            bloc.state.statusTEC.text = user?.status ?? "";
            return Form(
              child: Column(
                children: [
                  TextField(
                    enabled: state is EditingUser || isCreate,
                    controller: state.nameTEC,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.man),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser || isCreate,
                    controller: state.emailTEC,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser || isCreate,
                    controller: state.genderTEC,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.add_to_home_screen_outlined),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser || isCreate,
                    controller: state.statusTEC,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.woman_2),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  Visibility(
                    visible: !isCreate,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: state is EditingUser
                              ? () => bloc.add(UpdateUser(User(
                                  id: user!.id,
                                  name: state.nameTEC.text,
                                  email: state.emailTEC.text,
                                  gender: state.genderTEC.text,
                                  status: state.statusTEC.text)))
                              : null,
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50)),
                          child: const Text('SIMPAN'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () => bloc.add(DeleteUser(user!.id)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                minimumSize: const Size.fromHeight(50)),
                            child: const Text('HAPUS PENGGUNA'))
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Visibility(
                    visible: isCreate,
                    child: ElevatedButton(
                      onPressed: () {
                        User data = User(
                          id: 0,
                          name: bloc.state.nameTEC.text,
                          email: bloc.state.emailTEC.text,
                          gender: bloc.state.genderTEC.text,
                          status: bloc.state.statusTEC.text,
                        );
                        bloc.add(StoreUser(data));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      child: const Text('BUAT PENGGUNA'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isCreate,
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () => bloc.add(EditUser()),
          tooltip: 'Edit User',
          child: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
