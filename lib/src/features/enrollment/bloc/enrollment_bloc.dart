import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../custom_widgets/custom_exception.dart';
import '../../../utils/repository/staff_repository.dart';
// import '../repository/enrollment_process.dart';
import '../../../utils/model/staff_model.dart';

part 'enrollment_event.dart';
part 'enrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final StaffRepository _repository = StaffRepository();
  EnrollmentBloc() : super(EnrollmentInitial()) {
    on<StaffCodeEnrollmentEvent>(staffCodeEnrollmentEvent);
    on<CaptureEnrollmentEvent>(captureEnrollmentEvent);
  }

  FutureOr<void> staffCodeEnrollmentEvent(
      StaffCodeEnrollmentEvent event, Emitter<EnrollmentState> emit) async {
    emit(EnrollmentLoadingState());
    try {
      // EnrollmentRepository
      final staffInfo =
          await _repository.getStaffInformation(event.staffCode, 'enrollment');

      emit(EnrollmentSuccessState(staff: staffInfo));
    } on AccessDeniedError catch (e) {
      emit(EnrollmentFailState(error: e.message));
    } on ResultNotFoundError catch (e) {
      emit(EnrollmentFailState(error: e.message));
    } on ServerError catch (e) {
      emit(EnrollmentFailState(error: e.message));
    } on NetworkError catch (e) {
      emit(EnrollmentFailState(error: e.message));
    } catch (e) {
      emit(EnrollmentFailState(error: e.toString()));
    }
  }

  FutureOr<void> captureEnrollmentEvent(
      CaptureEnrollmentEvent event, Emitter<EnrollmentState> emit) async {
    emit(EnrollmentLoadingState());
    try {
      // EnrollmentRepository
      await _repository.processEnrollment(event.staffCode);
      emit(EnrollmentSuccessfulState());
    } on ResultNotFoundError catch (e) {
      emit(EnrollmentFailState(error: e.message));
    } catch (e) {
      emit(EnrollmentFailState(error: e.toString()));
    }
  }
}
