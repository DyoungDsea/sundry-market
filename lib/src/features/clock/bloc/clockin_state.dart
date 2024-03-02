part of 'clockin_bloc.dart';

abstract class ClockinState extends Equatable {
  const ClockinState();

  @override
  List<Object> get props => [];
}

class ClockinInitial extends ClockinState {}

class ClockinIsLoadingState extends ClockinState {}


class ClockinFailState extends ClockinState {
  final String error;

  const ClockinFailState({required this.error});
}

class ClockinSuccessState extends ClockinState {
  final Staff staff;

  const ClockinSuccessState({required this.staff});

  @override
  List<Object> get props => [staff];
}
