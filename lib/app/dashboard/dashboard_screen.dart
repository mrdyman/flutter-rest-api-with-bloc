import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_idstar/app/dashboard/bloc/dashboard_bloc.dart';

import '../../models/user.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ScrollController controller = ScrollController();
  late DashboardBloc bloc;
  late List<User>? users;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      bloc.add(GetInfinityUsers(users: users));
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<DashboardBloc>(context);
    bloc.add(GetUsers());
    controller.addListener(onScroll);
    return Scaffold(
      appBar: AppBar(
        title: const Text("TECHNICAL TEST IDSTAR"),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.grey[300],
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoaded) {
            users = (state).users;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        border: OutlineInputBorder(),
                        labelText: 'SEARCH',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                    onChanged: (value) => value == ""
                        ? bloc.add(GetUsers())
                        : bloc.add(SearchUser(state.users!, value)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: users!.length + 1,
                    itemBuilder: (context, index) {
                      return index < users!.length
                          ? buildCardItem(context, index, users![index], bloc)
                          : const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.add(CreateUser()),
        tooltip: 'Add New User',
        child: const Icon(Icons.add),
      ),
    );
  }

  Padding buildCardItem(
      BuildContext context, int index, User users, DashboardBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: GestureDetector(
        onTap: () => bloc.add(DetailUser(users)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("ID : ${users.id}"),
                    Text("Name : ${users.name}"),
                    Text("Email : ${users.email}"),
                    Text("Gender : ${users.gender}"),
                    Text("Status : ${users.status}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
