part of 'capture_bloc.dart';

abstract class CaptureState extends Equatable {
  const CaptureState();

  @override
  List<Object> get props => [];
}

class CaptureInitial extends CaptureState {}

class CaptureLoadingState extends CaptureState {}

class CaptureSuccessState extends CaptureState {}

class CaptureFailState extends CaptureState {
  final String error;

  const CaptureFailState({required this.error});
}
