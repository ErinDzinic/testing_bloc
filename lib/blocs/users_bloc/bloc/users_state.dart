part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersLoading extends UsersState {}

final class UsersLoaded extends UsersState {
  final List<UserModel> users;

  const UsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

final class UsersErrorState extends UsersState {
  final String error;
  const UsersErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
