import 'package:equatable/equatable.dart';

abstract class GetAddressStatus extends Equatable {}

class SuccessGetAddress extends GetAddressStatus {
  final String? sourceAddress;
  final String? destinationAddress;

  SuccessGetAddress({this.destinationAddress, this.sourceAddress});

  @override
  List<Object?> get props => [sourceAddress, destinationAddress];
}

class LoadingGetAddress extends GetAddressStatus {
  @override
  List<Object?> get props => [];
}

class FailedGetAddress extends GetAddressStatus {
  @override
  List<Object?> get props => [];
}
