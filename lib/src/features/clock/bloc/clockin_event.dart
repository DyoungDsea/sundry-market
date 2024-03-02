// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'clockin_bloc.dart';

abstract class ClockinEvent extends Equatable {
  const ClockinEvent();

  @override
  List<Object> get props => [];
}

class StaffClock extends ClockinEvent {
  final String staffCode;
  final String status;
  const StaffClock({
    required this.staffCode,
    required this.status,
  });
}
