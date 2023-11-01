import 'package:bloc/bloc.dart';
import 'package:bloc_test/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../models/api_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository _userRepository;
  UsersBloc(this._userRepository) : super(UsersLoading()) {
    on<LoadUsersEvent>(
      (event, emit) async {
        emit(UsersLoading());
        try {
          final users = await _userRepository.fetchPosts();
          emit(UsersLoaded(users: users));
        } catch (error) {
          emit(UsersErrorState(error: error.toString()));
        }
      },
    );
  }
}
