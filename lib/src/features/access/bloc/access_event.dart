
part of 'access_bloc.dart';

abstract class AccessEvent extends Equatable {
  const AccessEvent();

  @override
  List<Object> get props => [];
}

class CompanyAccess extends AccessEvent {
  final String companyCode;
  const CompanyAccess({required this.companyCode});
}
