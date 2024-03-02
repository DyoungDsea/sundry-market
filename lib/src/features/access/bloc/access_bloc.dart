import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../custom_widgets/custom_exception.dart';
import '../repository/access_process.dart';

part 'access_event.dart';
part 'access_state.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  AccessRepository accessRepository = AccessRepository();
  AccessBloc() : super(AccessInitial()) {
    on<CompanyAccess>(accessEvent);
  }

  FutureOr<void> accessEvent(
      CompanyAccess event, Emitter<AccessState> emit) async {
    emit(AccessIsLoadingState());
    try {
      // AccessRepository
      await accessRepository.companyAccessCode(event.companyCode);
      emit(AccessSuccessState());
    } on ResultNotFoundError catch (e) {
      emit(AccessFailState(error: e.message));
    } on AccessDeniedError catch (e) {
      emit(AccessFailState(error: e.message));
    } on LoginFailedError catch (e) {
      emit(AccessFailState(error: e.message));
    } on ServerError catch (e) {
      emit(AccessFailState(error: e.message));
    } on NetworkError catch (e) {
      emit(AccessFailState(error: e.message));
    } catch (e) {
      emit(AccessFailState(error: e.toString()));
    }
  }
}
