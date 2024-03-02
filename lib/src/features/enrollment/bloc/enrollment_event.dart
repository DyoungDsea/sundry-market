
part of 'enrollment_bloc.dart';

abstract class EnrollmentEvent extends Equatable {
  const EnrollmentEvent();

  @override
  List<Object> get props => [];
}

class StaffCodeEnrollmentEvent extends EnrollmentEvent {
  final String staffCode;
  const StaffCodeEnrollmentEvent({required this.staffCode});
}

class CaptureEnrollmentEvent extends EnrollmentEvent {
  final String staffCode;
  const CaptureEnrollmentEvent({required this.staffCode});
}
