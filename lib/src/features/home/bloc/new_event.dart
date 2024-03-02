part of 'new_bloc.dart';

sealed class NewEvent extends Equatable {
  const NewEvent();

  @override
  List<Object> get props => [];
}

class NetworkMode extends NewEvent {}

class AppMode extends NewEvent {
  final bool appState;

  const AppMode(this.appState);
}

class OfflineEvent extends NewEvent {
  final String staffcode;

  const OfflineEvent(this.staffcode);
}
