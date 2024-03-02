part of 'new_bloc.dart';

sealed class NewState extends Equatable {
  const NewState();

  @override
  List<Object> get props => [];
}

final class NewInitial extends NewState {}

final class NetworkState extends NewState {}
final class OfflineState extends NewState {}
final class OnlineState extends NewState {}
final class IsOfflineState extends NewState {}

final class OfflineLoading extends NewState {}
final class OfflineSuccess extends NewState {}
final class OfflineFailed extends NewState {}

final class IsEnableState extends NewState {
  final bool isEnable;

  const IsEnableState({this.isEnable = false});
}
