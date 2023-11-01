import 'package:bloc_test/repository/user_repository.dart';
import 'package:bloc_test/blocs/users_bloc/bloc/users_bloc.dart';
import 'package:bloc_test/models/api_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(UserRepository())..add(LoadUsersEvent()),
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UsersLoaded) {
            List<UserModel> users = state.users;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                        color: Theme.of(context).cardColor,
                        child: ListTile(
                            title: Text(
                              '${users[index].firstName}  ${users[index].lastName}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              '${users[index].email}',
                              style: const TextStyle(color: Colors.black),
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(users[index].avatar.toString()),
                            ))),
                  );
                });
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
