import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../custom_widgets/custom_exception.dart';
import '../../../utils/repository/staff_repository.dart';

part 'capture_event.dart';
part 'capture_state.dart';

class CaptureBloc extends Bloc<CaptureEvent, CaptureState> {
  StaffRepository staffRepository = StaffRepository();
  CaptureBloc() : super(CaptureInitial()) {
    on<StaffCapture>(staffCapture);
  }

  FutureOr<void> staffCapture(
      StaffCapture event, Emitter<CaptureState> emit) async {
    emit(CaptureLoadingState());
    try {
      await staffRepository.processClock(event.staffCode, event.status);
      emit(CaptureSuccessState());
    } on ResultNotFoundError catch (e) {
      emit(CaptureFailState(error: e.message));
    } catch (e) {
      emit(CaptureFailState(error: e.toString()));
    }
  }
}
