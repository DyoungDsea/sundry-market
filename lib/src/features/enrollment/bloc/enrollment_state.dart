part of 'enrollment_bloc.dart';

abstract class EnrollmentState extends Equatable {
  const EnrollmentState();

  @override
  List<Object> get props => [];
}

class EnrollmentInitial extends EnrollmentState {}

class EnrollmentLoadingState extends EnrollmentState {}
class EnrollmentSuccessfulState extends EnrollmentState {}

class EnrollmentSuccessState extends EnrollmentState {
  final Staff staff;

  const EnrollmentSuccessState({required this.staff});

  @override
  List<Object> get props => [staff];
}


class EnrollmentFailState extends EnrollmentState {
  final String error;

  const EnrollmentFailState({required this.error});
}
