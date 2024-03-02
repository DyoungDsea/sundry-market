import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfflineModeEvent extends Equatable {
  final String type;

  const OfflineModeEvent(this.type);

  static const enableOfflineMode = OfflineModeEvent('enableOfflineMode');
  static const disableOfflineMode = OfflineModeEvent('disableOfflineMode');
  static const checkNetwork = OfflineModeEvent('checkNetwork');

  @override
  List<Object> get props => [type];
}

class OfflineModeState {
  final bool isOfflineModeEnabled;

  OfflineModeState({required this.isOfflineModeEnabled});
}

class OfflineModeBloc extends Bloc<OfflineModeEvent, OfflineModeState> {
  OfflineModeBloc() : super(OfflineModeState(isOfflineModeEnabled: false)) {
    on<OfflineModeEvent>(offlineModeEvent);
  }

  void offlineModeEvent(
      OfflineModeEvent event, Emitter<OfflineModeState> emit) {
    if (event == OfflineModeEvent.enableOfflineMode) {
      emit(OfflineModeState(isOfflineModeEnabled: true));
    } else if (event == OfflineModeEvent.disableOfflineMode) {
      emit(OfflineModeState(isOfflineModeEnabled: false));
    } else if (event == OfflineModeEvent.checkNetwork) {
      // Handle check network event here
    }
  }
}
