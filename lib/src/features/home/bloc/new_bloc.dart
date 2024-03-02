import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/functions.dart';
import '../offline/repo/repository.dart';
import '../repo/network_connection.dart';

part 'new_event.dart';
part 'new_state.dart';

class NewBloc extends Bloc<NewEvent, NewState> {
  DatabaseAssistance databaseAssistance = DatabaseAssistance();
  //?check the network state
  NewBloc() : super(NewInitial()) {
    on<AppMode>(appMode);
    on<NetworkMode>(networkMode);
    on<OfflineEvent>(offlineEvent);
  }

  FutureOr<void> networkMode(NetworkMode event, Emitter<NewState> emit) async {
    //?check the network state
    final bool result = await CheckNetwork.checkConnectivity();
    if (result) {
      emit(IsOfflineState());
    } else {
      //*device is connected
      await databaseAssistance.submitAndDeleteAllRecords();
    }
  }

  FutureOr<void> appMode(AppMode event, Emitter<NewState> emit) {
    //?check the mode of the app if user want to go offline or not
    if (event.appState == true) {
      emit(OfflineState());
    } else if (event.appState == false) {
      emit(OnlineState());
    }
  }

  FutureOr<void> offlineEvent(
      OfflineEvent event, Emitter<NewState> emit) async {
    try {
      final staffcode = event.staffcode;
      final date = AppFunctions.getCurrentDate();
      final time = AppFunctions.getCurrentTime();
      // print("Date: $date, time: $time");
      emit(OfflineLoading());

      final result = await CheckNetwork.checkConnectivity();
      if (result) {
        await databaseAssistance.insertRecord(staffcode, date, time);
        emit(OfflineSuccess());
      } else {
        emit(OnlineState());
      }
    } catch (e) {
      emit(OfflineFailed());
    }
  }
}
