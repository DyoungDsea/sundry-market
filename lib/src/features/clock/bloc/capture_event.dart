// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'capture_bloc.dart';

abstract class CaptureEvent extends Equatable {
  const CaptureEvent();

  @override
  List<Object> get props => [];
}

class StaffCapture extends CaptureEvent {
  final String staffCode;
  final String status;
  const StaffCapture({
    required this.staffCode,
    required this.status,
  });
}
