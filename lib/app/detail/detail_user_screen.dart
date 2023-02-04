import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';
import 'bloc/detail_user_bloc.dart';

class DetailUserScreen extends StatelessWidget {
  final User? user;
  const DetailUserScreen({super.key, this.user});

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
            return Form(
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    enabled: state is EditingUser,
                    controller: TextEditingController(text: user?.name),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.man),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                    onChanged: (value) => user?.name = value,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser,
                    controller: TextEditingController(text: user?.email),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                    onChanged: (value) => user?.email = value,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser,
                    controller: TextEditingController(text: user?.gender),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.add_to_home_screen_outlined),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                    onChanged: (value) => user?.gender = value,
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    enabled: state is EditingUser,
                    controller: TextEditingController(text: user?.status),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.woman_2),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                    onChanged: (value) => user?.status = value,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: state is EditingUser
                        ? () => bloc.add(UpdateUser(user!))
                        : null,
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    child: const Text('SIMPAN'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () => 1,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          minimumSize: const Size.fromHeight(50)),
                      child: const Text('HAPUS PENGGUNA'))
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () => bloc.add(EditUser()),
        tooltip: 'Edit User',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
