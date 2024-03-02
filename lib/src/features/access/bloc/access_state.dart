part of 'access_bloc.dart';

abstract class AccessState extends Equatable {
  const AccessState();

  @override
  List<Object> get props => [];
}

class AccessInitial extends AccessState {}

class AccessIsLoadingState extends AccessState {}

class AccessSuccessState extends AccessState {}

class AccessFailState extends AccessState {
  final String error;

  const AccessFailState({required this.error});
}
