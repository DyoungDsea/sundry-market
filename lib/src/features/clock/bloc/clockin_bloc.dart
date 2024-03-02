import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../custom_widgets/custom_exception.dart';
import '../../../utils/model/staff_model.dart';
import '../../../utils/repository/staff_repository.dart';

part 'clockin_event.dart';
part 'clockin_state.dart';

class ClockinBloc extends Bloc<ClockinEvent, ClockinState> {
  StaffRepository staffRepository = StaffRepository();
  ClockinBloc() : super(ClockinInitial()) {
    on<StaffClock>(staffClock);
  }

  FutureOr<void> staffClock(
      StaffClock event, Emitter<ClockinState> emit) async {
    emit(ClockinIsLoadingState());
    try {
      // ClocinRepository
      final staffInfo = await staffRepository.getStaffInformation(
        event.staffCode,
        event.status,
      );
      emit(ClockinSuccessState(staff: staffInfo));
    } on ResultNotFoundError catch (e) {
      emit(ClockinFailState(error: e.message));
    } on AccessDeniedError catch (e) {
      emit(ClockinFailState(error: e.message));
    } on ServerError catch (e) {
      emit(ClockinFailState(error: e.message));
    } on NetworkError catch (e) {
      emit(ClockinFailState(error: e.message));
    } catch (e) {
      emit(ClockinFailState(error: e.toString()));
    }
  }
}
